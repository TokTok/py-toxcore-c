import collections
import time
import unittest
from dataclasses import dataclass
from dataclasses import field
from typing import Callable

import pytox.toxcore.tox as core


@dataclass
class TestException(Exception):
    status: core.Tox_Connection


@dataclass
class FriendInfo:
    connection_status: core.Tox_Connection = core.TOX_CONNECTION_NONE
    status: core.Tox_User_Status = core.TOX_USER_STATUS_NONE
    status_message: bytes = b""
    name: bytes = b""
    request_message: bytes = b""
    messages: list[tuple[core.Tox_Message_Type, bytes]] = field(
        default_factory=list)
    lossy_packets: list[bytes] = field(default_factory=list)
    lossless_packets: list[bytes] = field(default_factory=list)


class TestTox(core.Tox_Ptr):
    index: int
    connection_status_from_cb = core.TOX_CONNECTION_NONE
    friends: dict[int, FriendInfo]

    def __init__(self, index: int) -> None:
        super(TestTox, self).__init__()
        self.index = index
        self.friends = collections.defaultdict(FriendInfo)

    def handle_self_connection_status(self,
                                      connection_status: core.Tox_Connection
                                      ) -> None:
        self.connection_status_from_cb = connection_status
        raise TestException(connection_status)

    def handle_friend_request(self, public_key: bytes, message: bytes) -> None:
        friend_number = self.friend_add_norequest(public_key)
        self.friends[friend_number].request_message = message

    def handle_friend_connection_status(
            self,
            friend_number: int,
            connection_status: core.Tox_Connection,
    ) -> None:
        self.friends[friend_number].connection_status = connection_status

    def handle_friend_message(self, friend_number: int,
                              type_: core.Tox_Message_Type,
                              message: bytes) -> None:
        self.friends[friend_number].messages.append((type_, message))

    def handle_friend_lossy_packet(self, friend_number: int,
                                   message: bytes) -> None:
        self.friends[friend_number].lossy_packets.append(message)
        raise Exception("OMG")

    def handle_friend_lossless_packet(self, friend_number: int,
                                      message: bytes) -> None:
        self.friends[friend_number].lossless_packets.append(message)

    def handle_friend_name(self, friend_number: int, name: bytes) -> None:
        self.friends[friend_number].name = name

    def handle_friend_status(self, friend_number: int, status: core.Tox_User_Status) -> None:
        self.friends[friend_number].status = status

    def handle_friend_status_message(self, friend_number: int, status_message: bytes) -> None:
        self.friends[friend_number].status_message = status_message


class AutoTest(unittest.TestCase):

    # TODO(iphydf): Use per-test toxes. Use Tox_Time to speed this up.
    tox1 = TestTox(1)
    tox2 = TestTox(2)
    tox3 = TestTox(3)

    def _iterate(self, max_iterate: int, cond: Callable[[], bool]) -> None:
        for _ in range(0, max_iterate):
            if not cond():
                return
            self.tox1.iterate()
            self.tox2.iterate()
            self.tox3.iterate()
            time.sleep(self.tox1.iteration_interval / 1000)
        self.fail(f"condition not met after {max_iterate} iterations")

    def _wait_for_self_online(self) -> None:
        def is_online() -> bool:
            return bool(
                self.tox1.connection_status == core.TOX_CONNECTION_NONE
                or self.tox2.connection_status == core.TOX_CONNECTION_NONE
                or self.tox3.connection_status == core.TOX_CONNECTION_NONE)

        # At most 20 seconds.
        self._iterate(
            1000,
            is_online,
        )

    def _wait_for_friend_online(self) -> None:
        def is_online() -> bool:
            return (self.tox1.friends[0].connection_status ==
                    core.TOX_CONNECTION_NONE
                    or self.tox2.friends[0].connection_status ==
                    core.TOX_CONNECTION_NONE
                    or self.tox2.friends[1].connection_status ==
                    core.TOX_CONNECTION_NONE
                    or self.tox3.friends[0].connection_status ==
                    core.TOX_CONNECTION_NONE)

        # At most 5 seconds.
        self._iterate(250, is_online)

    def test_connection_status_cb(self) -> None:
        for tox in (self.tox1, self.tox2, self.tox3):
            # Test that exceptions can pass through C code.
            with self.assertRaises(TestException) as ex:
                self._wait_for_self_online()
                self.assertEqual(tox.connection_status,
                                 tox.connection_status_from_cb)
            self.assertEqual(ex.exception.status, tox.connection_status)

    def test_friend_add(self) -> None:
        self.tox1.friend_add(self.tox2.address,
                             b"are you gonna be my best friend?")
        self.tox2.friend_add(self.tox3.address,
                             b"lala lala lala la I'm Mr. Happy Face")
        self._wait_for_friend_online()
        self.assertEqual(
            self.tox2.friends[self.tox2.friend_by_public_key(
                self.tox1.public_key)].request_message,
            b"are you gonna be my best friend?",
        )
        self.assertEqual(
            self.tox3.friends[self.tox3.friend_by_public_key(
                self.tox2.public_key)].request_message,
            b"lala lala lala la I'm Mr. Happy Face",
        )

    def test_friend_by_public_key(self) -> None:
        with self.assertRaises(core.ApiException) as ex:
            # We're not our own friend.
            self.tox1.friend_by_public_key(self.tox1.public_key)
        self.assertEqual(ex.exception.error,
                         core.TOX_ERR_FRIEND_BY_PUBLIC_KEY_NOT_FOUND)

    def test_send_message(self) -> None:
        self._wait_for_friend_online()
        self.tox1.friend_send_message(0, core.TOX_MESSAGE_TYPE_NORMAL,
                                      b"hello there!")
        friend = self.tox2.friends[self.tox2.friend_by_public_key(
            self.tox1.public_key)]
        self._iterate(100, lambda: not friend.messages)
        self.assertEqual(friend.messages[0],
                         (core.TOX_MESSAGE_TYPE_NORMAL, b"hello there!"))

    # TODO(iphydf): This one doesn't pass. Investigate why.
    #   def test_send_lossy_packet(self) -> None:
    #       self._wait_for_friend_online()
    #       self.tox1.friend_send_lossy_packet(0, b"\xc0hello there!")
    #       friend = self.tox2.friends[self.tox2.friend_by_public_key(
    #           self.tox1.public_key)]
    #       self._iterate(100, lambda: not friend.lossy_packets)
    #       self.assertEqual(friend.lossy_packets[0], b"\xc0hello there!")

    def test_send_lossless_packet(self) -> None:
        self._wait_for_friend_online()
        self.tox1.friend_send_lossless_packet(0, b"\xa0general kenobi.")
        friend = self.tox2.friends[self.tox2.friend_by_public_key(
            self.tox1.public_key)]
        self._iterate(100, lambda: not friend.lossless_packets)
        self.assertEqual(friend.lossless_packets[0], b"\xa0general kenobi.")

    def test_status(self) -> None:
        self._wait_for_friend_online()
        self.assertEqual(self.tox1.status, core.TOX_USER_STATUS_NONE)
        self.tox1.status = core.TOX_USER_STATUS_AWAY
        self.assertEqual(self.tox1.status, core.TOX_USER_STATUS_AWAY)
        friend_number = self.tox2.friend_by_public_key(self.tox1.public_key)
        friend = self.tox2.friends[friend_number]
        self._iterate(100, lambda: friend.status == core.TOX_USER_STATUS_NONE)
        self.assertEqual(friend.status, core.TOX_USER_STATUS_AWAY)
        self.assertEqual(self.tox2.friend_get_status(
            friend_number), core.TOX_USER_STATUS_AWAY)

    def test_name(self) -> None:
        self._wait_for_friend_online()
        self.assertEqual(self.tox1.name, b"")
        self.tox1.name = b"Now that's a name I haven't heard in a long time"
        self.assertEqual(
            self.tox1.name, b"Now that's a name I haven't heard in a long time")
        friend_number = self.tox2.friend_by_public_key(self.tox1.public_key)
        friend = self.tox2.friends[friend_number]
        self._iterate(100, lambda: friend.name == b"")
        self.assertEqual(
            friend.name, b"Now that's a name I haven't heard in a long time")
        self.assertEqual(self.tox2.friend_get_name(friend_number),
                         b"Now that's a name I haven't heard in a long time")

    def test_status_message(self) -> None:
        self._wait_for_friend_online()
        self.assertEqual(self.tox1.status_message, b"")
        self.tox1.status_message = b"Python rocks!"
        self.assertEqual(self.tox1.status_message, b"Python rocks!")
        friend_number = self.tox2.friend_by_public_key(self.tox1.public_key)
        friend = self.tox2.friends[friend_number]
        self._iterate(100, lambda: friend.status_message == b"")
        self.assertEqual(friend.status_message, b"Python rocks!")
        self.assertEqual(self.tox2.friend_get_status_message(
            friend_number), b"Python rocks!")


if __name__ == "__main__":
    unittest.main()

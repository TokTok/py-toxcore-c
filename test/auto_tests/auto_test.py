import collections
import time
import unittest
from dataclasses import dataclass
from dataclasses import field
from typing import Callable

import pytox.toxcore.tox as core


@dataclass
class FriendInfo:
    connection_status: core.Tox_Connection = core.TOX_CONNECTION_NONE
    status: core.Tox_User_Status = core.TOX_USER_STATUS_NONE
    status_message: bytes = b""
    name: bytes = b""
    request_message: bytes = b""
    typing: bool = False
    messages: list[tuple[core.Tox_Message_Type, bytes]] = field(default_factory=list)
    # message_id -> read receipt
    messages_sent: dict[int, bool] = field(
        default_factory=lambda: collections.defaultdict(bool)
    )
    lossy_packets: list[bytes] = field(default_factory=list)
    lossless_packets: list[bytes] = field(default_factory=list)


@dataclass
class ConferencePeerInfo:
    name: bytes = b""


@dataclass
class ConferenceInfo:
    title: tuple[int, bytes] = (0, b"")
    inviter: int = -1
    connected: bool = False
    peers: dict[int, ConferencePeerInfo] = field(
        default_factory=lambda: collections.defaultdict(ConferencePeerInfo)
    )
    messages: list[tuple[int, core.Tox_Message_Type, bytes]] = field(
        default_factory=list
    )


class TestTox(core.Tox_Ptr):
    index: int
    connection_status = core.TOX_CONNECTION_NONE
    friends: dict[int, FriendInfo]
    conferences: dict[int, ConferenceInfo]

    def __init__(self, index: int) -> None:
        super(TestTox, self).__init__()
        self.index = index
        self.friends = collections.defaultdict(FriendInfo)
        self.conferences = collections.defaultdict(ConferenceInfo)
        self.name = f"tox{index}".encode("utf-8")

    def handle_self_connection_status(
        self, connection_status: core.Tox_Connection
    ) -> None:
        self.connection_status = connection_status

    def handle_friend_name(self, friend_number: int, name: bytes) -> None:
        self.friends[friend_number].name = name

    def handle_friend_status_message(
        self, friend_number: int, status_message: bytes
    ) -> None:
        self.friends[friend_number].status_message = status_message

    def handle_friend_status(
        self, friend_number: int, status: core.Tox_User_Status
    ) -> None:
        self.friends[friend_number].status = status

    def handle_friend_connection_status(
        self, friend_number: int, connection_status: core.Tox_Connection,
    ) -> None:
        self.friends[friend_number].connection_status = connection_status

    def handle_friend_typing(self, friend_number: int, typing: bool) -> None:
        self.friends[friend_number].typing = typing

    def handle_friend_read_receipt(self, friend_number: int, message_id: int) -> None:
        assert self.friends[friend_number].messages_sent[message_id] is False
        self.friends[friend_number].messages_sent[message_id] = True

    def handle_friend_request(self, public_key: bytes, message: bytes) -> None:
        friend_number = self.friend_add_norequest(public_key)
        self.friends[friend_number].request_message = message

    def handle_friend_message(
        self, friend_number: int, type_: core.Tox_Message_Type, message: bytes
    ) -> None:
        self.friends[friend_number].messages.append((type_, message))

    def handle_friend_lossy_packet(self, friend_number: int, message: bytes) -> None:
        self.friends[friend_number].lossy_packets.append(message)
        raise Exception("OMG")

    def handle_friend_lossless_packet(self, friend_number: int, message: bytes) -> None:
        self.friends[friend_number].lossless_packets.append(message)

    def handle_file_recv_control(
        self, friend_number: int, file_number: int, control: core.Tox_File_Control
    ) -> None:
        pass

    def handle_file_chunk_request(
        self, friend_number: int, file_number: int, position: int, length: int
    ) -> None:
        pass

    def handle_file_recv(
        self,
        friend_number: int,
        file_number: int,
        kind: int,
        file_size: int,
        filename: bytes,
    ) -> None:
        pass

    def handle_file_recv_chunk(
        self, friend_number: int, file_number: int, position: int, data: bytes
    ) -> None:
        pass

    def handle_conference_peer_name(
        self, conference_number: int, peer_number: int, name: bytes
    ) -> None:
        self.conferences[conference_number].peers[peer_number].name = name

    def handle_conference_peer_list_changed(self, conference_number: int) -> None:
        pass

    def handle_conference_invite(
        self, friend_number: int, type_: core.Tox_Conference_Type, cookie: bytes
    ) -> None:
        assert type_ == core.TOX_CONFERENCE_TYPE_TEXT
        conference_number = self.conference_join(friend_number, cookie)
        self.conferences[conference_number].inviter = friend_number

    def handle_conference_connected(self, conference_number: int) -> None:
        self.conferences[conference_number].connected = True

    def handle_conference_message(
        self,
        conference_number: int,
        peer_number: int,
        type_: core.Tox_Message_Type,
        message: bytes,
    ) -> None:
        self.conferences[conference_number].messages.append(
            (peer_number, type_, message)
        )

    def handle_conference_title(
        self, conference_number: int, peer_number: int, title: bytes
    ) -> None:
        self.conferences[conference_number].title = (peer_number, title)


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
                or self.tox3.connection_status == core.TOX_CONNECTION_NONE
            )

        # At most 20 seconds.
        self._iterate(
            1000, is_online,
        )

    def _wait_for_friend_online(self) -> None:
        self._wait_for_self_online()
        if not self.tox1.friend_list:
            self.tox1.friend_add(self.tox2.address, b"are you gonna be my best friend?")
            self.tox2.friend_add(
                self.tox3.address, b"lala lala lala la I'm Mr. Happy Face"
            )

        def is_online() -> bool:
            return (
                self.tox1.friends[0].connection_status == core.TOX_CONNECTION_NONE
                or self.tox2.friends[0].connection_status == core.TOX_CONNECTION_NONE
                or self.tox2.friends[1].connection_status == core.TOX_CONNECTION_NONE
                or self.tox3.friends[0].connection_status == core.TOX_CONNECTION_NONE
            )

        # At most 5 seconds.
        self._iterate(250, is_online)

    def test_friend_add(self) -> None:
        self._wait_for_friend_online()
        self.assertEqual(
            self.tox2.friends[
                self.tox2.friend_by_public_key(self.tox1.public_key)
            ].request_message,
            b"are you gonna be my best friend?",
        )
        self.assertEqual(
            self.tox3.friends[
                self.tox3.friend_by_public_key(self.tox2.public_key)
            ].request_message,
            b"lala lala lala la I'm Mr. Happy Face",
        )

    def test_friend_by_public_key(self) -> None:
        with self.assertRaises(core.ApiException) as ex:
            # We're not our own friend.
            self.tox1.friend_by_public_key(self.tox1.public_key)
        self.assertEqual(
            ex.exception.error, core.TOX_ERR_FRIEND_BY_PUBLIC_KEY_NOT_FOUND
        )

    def test_send_message(self) -> None:
        self._wait_for_friend_online()
        self.tox1.friend_send_message(0, core.TOX_MESSAGE_TYPE_NORMAL, b"hello there!")
        friend = self.tox2.friends[self.tox2.friend_by_public_key(self.tox1.public_key)]
        self._iterate(100, lambda: not friend.messages)
        self.assertEqual(
            friend.messages[0], (core.TOX_MESSAGE_TYPE_NORMAL, b"hello there!")
        )

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
        friend = self.tox2.friends[self.tox2.friend_by_public_key(self.tox1.public_key)]
        self._iterate(100, lambda: not friend.lossless_packets)
        self.assertEqual(friend.lossless_packets[0], b"\xa0general kenobi.")

    def test_status(self) -> None:
        self._wait_for_friend_online()
        friend_number = self.tox2.friend_by_public_key(self.tox1.public_key)
        friend = self.tox2.friends[friend_number]
        self.assertEqual(self.tox1.status, core.TOX_USER_STATUS_NONE)
        self.tox1.status = core.TOX_USER_STATUS_AWAY
        self.assertEqual(self.tox1.status, core.TOX_USER_STATUS_AWAY)
        self._iterate(100, lambda: friend.status == core.TOX_USER_STATUS_NONE)
        self.assertEqual(friend.status, core.TOX_USER_STATUS_AWAY)
        self.assertEqual(
            self.tox2.friend_get_status(friend_number), core.TOX_USER_STATUS_AWAY
        )

    def test_name(self) -> None:
        self._wait_for_friend_online()
        friend_number = self.tox2.friend_by_public_key(self.tox1.public_key)
        friend = self.tox2.friends[friend_number]
        self.assertEqual(self.tox1.name, b"tox1")
        self.tox1.name = b"Now that's a name I haven't heard in a long time"
        self.assertEqual(
            self.tox1.name, b"Now that's a name I haven't heard in a long time"
        )
        self._iterate(100, lambda: friend.name == b"tox1")
        self.assertEqual(
            friend.name, b"Now that's a name I haven't heard in a long time"
        )
        self.assertEqual(
            self.tox2.friend_get_name(friend_number),
            b"Now that's a name I haven't heard in a long time",
        )

    def test_status_message(self) -> None:
        self._wait_for_friend_online()
        friend_number = self.tox2.friend_by_public_key(self.tox1.public_key)
        friend = self.tox2.friends[friend_number]
        self.assertEqual(self.tox1.status_message, b"")
        self.tox1.status_message = b"Python rocks!"
        self.assertEqual(self.tox1.status_message, b"Python rocks!")
        self._iterate(100, lambda: friend.status_message == b"")
        self.assertEqual(friend.status_message, b"Python rocks!")
        self.assertEqual(
            self.tox2.friend_get_status_message(friend_number), b"Python rocks!"
        )

    def test_typing(self) -> None:
        self._wait_for_friend_online()
        friend_number = self.tox2.friend_by_public_key(self.tox1.public_key)
        friend = self.tox2.friends[friend_number]
        self.assertFalse(friend.typing)
        self.assertFalse(self.tox2.friend_get_typing(friend_number))
        self.tox1.set_typing(0, True)
        self._iterate(100, lambda: not friend.typing)
        self.assertTrue(self.tox2.friend_get_typing(friend_number))

    def test_read_receipt(self) -> None:
        self._wait_for_friend_online()
        friend_number = self.tox1.friend_by_public_key(self.tox2.public_key)
        friend = self.tox1.friends[friend_number]
        msg_id = self.tox1.friend_send_message(
            friend_number, core.TOX_MESSAGE_TYPE_NORMAL, b"hello there!"
        )
        self.assertFalse(friend.messages_sent[msg_id])
        self._iterate(100, lambda: not friend.messages_sent[msg_id])

    def test_conference_invite(self) -> None:
        self._wait_for_friend_online()
        # tox1 creates conference.
        cnum1 = self.tox1.conference_new()
        self.assertListEqual(self.tox1.conference_chatlist, [cnum1])
        # tox1 invites tox2 to conference.
        self.tox1.conference_invite(
            self.tox1.friend_by_public_key(self.tox2.public_key), cnum1
        )
        # wait for tox2 to join conference.
        self._iterate(100, lambda: not self.tox2.conference_chatlist)
        self.assertEqual(len(self.tox2.conference_chatlist), 1)
        # wait for group connection.
        cnum2 = self.tox2.conference_chatlist[0]
        self._iterate(100, lambda: not self.tox2.conferences[cnum2].connected)
        # tox2 invites tox3 to conference.
        self.tox2.conference_invite(
            self.tox2.friend_by_public_key(self.tox3.public_key), cnum2
        )
        # wait for tox3 to join conference.
        self._iterate(100, lambda: not self.tox3.conference_chatlist)
        self.assertEqual(len(self.tox3.conference_chatlist), 1)

    def test_conference_message(self) -> None:
        self._wait_for_friend_online()
        cnum1 = self.tox1.conference_chatlist[0]
        cnum2 = self.tox2.conference_chatlist[0]
        cnum3 = self.tox3.conference_chatlist[0]
        # wait for all toxes to see all 3 peers.
        self._iterate(
            100,
            lambda: any(
                len(tox.conferences[tox.conference_chatlist[0]].peers) < 2
                for tox in (self.tox1, self.tox2, self.tox3)
            ),
        )
        # wait for group connection.
        self._iterate(100, lambda: not self.tox2.conferences[cnum2].connected)
        # tox2 sends message to conference.
        self.tox2.conference_send_message(
            cnum2, core.TOX_MESSAGE_TYPE_NORMAL, b"hello there!"
        )
        # wait for tox1 to receive message.
        self._iterate(
            100,
            lambda: any(
                not tox.conferences[tox.conference_chatlist[0]].messages
                for tox in (self.tox1, self.tox2, self.tox3)
            ),
        )
        self.assertEqual(
            self.tox1.conferences[cnum1].messages[0],
            (1, core.TOX_MESSAGE_TYPE_NORMAL, b"hello there!"),
        )
        self.assertEqual(
            self.tox2.conferences[cnum2].messages[0],
            (1, core.TOX_MESSAGE_TYPE_NORMAL, b"hello there!"),
        )
        self.assertEqual(
            self.tox3.conferences[cnum3].messages[0],
            (1, core.TOX_MESSAGE_TYPE_NORMAL, b"hello there!"),
        )


if __name__ == "__main__":
    unittest.main()

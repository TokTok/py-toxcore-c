import collections
import time
import unittest
from dataclasses import dataclass
from typing import Callable

import pytox.toxcore.tox as core


@dataclass
class TestException(Exception):
    status: core.Tox_Connection


@dataclass
class FriendInfo:
    connection_status: core.Tox_Connection = core.TOX_CONNECTION_NONE
    request_message: bytes = b""


class TestTox(core.Tox_Ptr):
    index: int
    connection_status_from_cb = core.TOX_CONNECTION_NONE
    friends: dict[int, FriendInfo]

    def __init__(self, index: int) -> None:
        with core.Tox_Options_Ptr() as options:
            options.local_discovery_enabled = False
            super(TestTox, self).__init__(options)
        self.index = index
        self.friends = collections.defaultdict(FriendInfo)

    def handle_self_connection_status(self,
                                      connection_status: core.Tox_Connection
                                      ) -> None:
        self.connection_status_from_cb = connection_status
        raise TestException(connection_status)

    def handle_friend_connection_status(
            self,
            friend_number: int,
            connection_status: core.Tox_Connection,
    ) -> None:
        self.friends[friend_number].connection_status = connection_status

    def handle_friend_request(self, public_key: bytes, message: bytes) -> None:
        friend_number = self.friend_add_norequest(public_key)
        self.friends[friend_number].request_message = message


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
        self.tox2.bootstrap("127.0.0.1", self.tox1.udp_port, self.tox1.dht_id)
        self.tox3.bootstrap("127.0.0.1", self.tox1.udp_port, self.tox1.dht_id)

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


if __name__ == "__main__":
    unittest.main()

import time
import unittest
from dataclasses import dataclass

import pytox.toxcore.tox as core


@dataclass
class TestException(Exception):
    status: core.Tox_Connection


class TestTox(core.Tox_Ptr):
    connection_status_from_cb = core.TOX_CONNECTION_NONE

    def handle_self_connection_status(
        self, connection_status: core.Tox_Connection
    ) -> None:
        print(connection_status)
        self.connection_status_from_cb = connection_status
        raise TestException(connection_status)


class AutoTest(unittest.TestCase):
    def test_connection_status_cb(self) -> None:
        with TestTox() as tox1:
            with TestTox() as tox2:
                # Test that exceptions can pass through C code.
                with self.assertRaises(TestException) as ex:
                    while (
                        tox1.connection_status == core.TOX_CONNECTION_NONE
                        or tox2.connection_status == core.TOX_CONNECTION_NONE
                    ):
                        tox1.iterate()
                        tox2.iterate()
                        time.sleep(tox1.iteration_interval / 1000)
                    self.assertEqual(
                        tox1.connection_status, tox1.connection_status_from_cb
                    )
                self.assertEqual(ex.exception.status, tox1.connection_status)


if __name__ == "__main__":
    unittest.main()

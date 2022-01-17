import time
import unittest

from pytox import core

class TestTox(core.Core):

    def __init__(self):
        super().__init__()
        self.connection_status_from_cb = core.TOX_CONNECTION_NONE

    def handle_self_connection_status(self, connection_status: core.Tox_Connection) -> None:
        print(connection_status)
        self.connection_status_from_cb = connection_status


class AutoTest(unittest.TestCase):

    def test_connection_status_cb(self):
        with TestTox() as tox1:
            with TestTox() as tox2:
                while (tox1.connection_status == core.TOX_CONNECTION_NONE or
                        tox2.connection_status == core.TOX_CONNECTION_NONE):
                    tox1.iterate()
                    tox2.iterate()
                    time.sleep(tox1.iteration_interval / 1000)
                self.assertEqual(tox1.connection_status, tox1.connection_status_from_cb)


if __name__ == '__main__':
    unittest.main()

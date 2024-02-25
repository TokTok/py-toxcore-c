import unittest

import pytox.toxcore.tox as c
from pytox import common


class ToxOptionsTest(unittest.TestCase):
    def test_options(self) -> None:
        opts = c.Tox_Options_Ptr()
        self.assertTrue(opts.ipv6_enabled)
        opts.ipv6_enabled = False
        self.assertFalse(opts.ipv6_enabled)

        self.assertTrue(opts.udp_enabled)
        opts.udp_enabled = False
        self.assertFalse(opts.udp_enabled)

        self.assertTrue(opts.local_discovery_enabled)
        opts.local_discovery_enabled = False
        self.assertFalse(opts.local_discovery_enabled)

        self.assertTrue(opts.dht_announcements_enabled)
        opts.dht_announcements_enabled = False
        self.assertFalse(opts.dht_announcements_enabled)

        self.assertTrue(opts.hole_punching_enabled)
        opts.hole_punching_enabled = False
        self.assertFalse(opts.hole_punching_enabled)

        self.assertEqual(opts.proxy_type, c.TOX_PROXY_TYPE_NONE)
        opts.proxy_type = c.TOX_PROXY_TYPE_SOCKS5
        self.assertEqual(opts.proxy_type, c.TOX_PROXY_TYPE_SOCKS5)

        opts.proxy_host = "localhost"
        self.assertEqual(opts.proxy_host, "localhost")

        opts.proxy_port = 1234
        self.assertEqual(opts.proxy_port, 1234)

        opts.start_port = 1235
        self.assertEqual(opts.start_port, 1235)

        opts.end_port = 1236
        self.assertEqual(opts.end_port, 1236)

        opts.tcp_port = 1237
        self.assertEqual(opts.tcp_port, 1237)

        opts.savedata_type = c.TOX_SAVEDATA_TYPE_TOX_SAVE
        self.assertEqual(opts.savedata_type, c.TOX_SAVEDATA_TYPE_TOX_SAVE)

        # Can't test whether it works, but at least we can test that it doesn't crash.
        opts.savedata_data = b"test"

        self.assertFalse(opts.experimental_thread_safety)
        opts.experimental_thread_safety = True
        self.assertTrue(opts.experimental_thread_safety)

        self.assertFalse(opts.experimental_groups_persistence)
        opts.experimental_groups_persistence = True
        self.assertTrue(opts.experimental_groups_persistence)

    def test_use_after_free(self) -> None:
        with c.Tox_Options_Ptr() as opts:
            pass
        with self.assertRaises(common.UseAfterFreeException):
            print(opts.ipv6_enabled)


if __name__ == "__main__":
    unittest.main()

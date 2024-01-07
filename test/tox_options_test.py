import unittest

import pytox.toxcore.tox as c
from pytox import common


class ToxOptionsTest(unittest.TestCase):
    def test_options(self) -> None:
        opts = c.Tox_Options_Ptr()
        self.assertTrue(opts.ipv6_enabled)
        opts.ipv6_enabled = False
        self.assertFalse(opts.ipv6_enabled)

    def test_use_after_free(self) -> None:
        with c.Tox_Options_Ptr() as opts:
            saved_opts = opts
        with self.assertRaises(common.UseAfterFreeException):
            print(saved_opts.ipv6_enabled)


if __name__ == "__main__":
    unittest.main()

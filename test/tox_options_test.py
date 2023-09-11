import unittest

from pytox import core, error, options


class ToxOptionsTest(unittest.TestCase):
    def test_options(self):
        opts = options.ToxOptions()
        self.assertTrue(opts.ipv6_enabled)
        opts.ipv6_enabled = False
        self.assertFalse(opts.ipv6_enabled)

    def test_use_after_free(self):
        with options.ToxOptions() as opts:
            saved_opts = opts
        with self.assertRaises(error.UseAfterFreeException):
            print(saved_opts.ipv6_enabled)


if __name__ == "__main__":
    unittest.main()

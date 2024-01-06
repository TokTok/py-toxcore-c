import unittest

import pytox.toxav.toxav as av


class AvTest(unittest.TestCase):
    def test_version(self):
        self.assertEqual(av.foo(), av.foo())


if __name__ == "__main__":
    unittest.main()

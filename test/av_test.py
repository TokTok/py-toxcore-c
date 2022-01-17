import time
import unittest

from pytox import av

class AvTest(unittest.TestCase):

    def test_version(self):
        self.assertEqual(av, av)


if __name__ == '__main__':
    unittest.main()

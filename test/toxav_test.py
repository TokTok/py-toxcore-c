from typing import cast
import unittest

from pytox.toxcore import tox
import pytox.toxav.toxav as av


class AvTest(unittest.TestCase):
    def test_version(self) -> None:
        with self.assertRaises(av.ApiException) as ex:
            av.Toxav_Ptr(cast(tox.Tox_Ptr, None))
        self.assertEqual(ex.exception.error, av.TOXAV_ERR_NEW_NULL)


if __name__ == "__main__":
    unittest.main()

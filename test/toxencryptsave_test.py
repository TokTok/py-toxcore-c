import unittest

from pytox import common
from pytox.toxencryptsave import toxencryptsave as c


class ToxencryptsaveTest(unittest.TestCase):
    def test_encrypt_decrypt(self):
        with c.Tox_Pass_Key_Ptr(b"hello") as pk:
            self.assertNotEqual(pk.encrypt(b"hello world"), b"hello world")
            self.assertEqual(pk.decrypt(pk.encrypt(b"hello world")),
                             b"hello world")

    def test_encrypt_decrypt_with_correct_salt(self):
        with c.Tox_Pass_Key_Ptr(b"hello", b"a" * 32) as pk1:
            with c.Tox_Pass_Key_Ptr(b"hello", b"a" * 32) as pk2:
                self.assertEqual(pk2.decrypt(pk1.encrypt(b"hello world")),
                                 b"hello world")

    def test_encrypt_decrypt_with_wrong_salt(self):
        with c.Tox_Pass_Key_Ptr(b"hello", b"a" * 32) as pk1:
            with c.Tox_Pass_Key_Ptr(b"hello", b"b" * 32) as pk2:
                with self.assertRaises(c.ApiException) as ex:
                    pk2.decrypt(pk1.encrypt(b"hello world"))
                self.assertEqual(ex.exception.error.name,
                                 c.TOX_ERR_DECRYPTION_FAILED.name)

    def test_salt_too_small(self):
        with self.assertRaises(common.LengthException):
            c.Tox_Pass_Key_Ptr(b"hello", b"world")


if __name__ == "__main__":
    unittest.main()

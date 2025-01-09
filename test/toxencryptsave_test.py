import unittest

from pytox import common
from pytox.toxencryptsave import toxencryptsave as c


class ToxencryptsaveTest(unittest.TestCase):

    def test_encrypt_decrypt(self) -> None:
        with c.Tox_Pass_Key_Ptr(b"hello") as pk:
            self.assertNotEqual(pk.encrypt(b"hello world"), b"hello world")
            self.assertEqual(pk.decrypt(pk.encrypt(b"hello world")),
                             b"hello world")

    def test_encrypt_decrypt_with_correct_salt(self) -> None:
        with c.Tox_Pass_Key_Ptr(b"hello", b"a" * 32) as pk1:
            with c.Tox_Pass_Key_Ptr(b"hello", b"a" * 32) as pk2:
                self.assertEqual(pk2.decrypt(pk1.encrypt(b"hello world")),
                                 b"hello world")

    def test_encrypt_decrypt_with_wrong_salt(self) -> None:
        with c.Tox_Pass_Key_Ptr(passphrase=b"hello", salt=b"a" * 32) as pk1:
            with c.Tox_Pass_Key_Ptr(b"hello", b"b" * 32) as pk2:
                with self.assertRaises(c.ApiException) as ex:
                    pk2.decrypt(pk1.encrypt(b"hello world"))
                self.assertEqual(ex.exception.code.name,
                                 c.TOX_ERR_DECRYPTION_FAILED.name)

    def test_salt_too_small(self) -> None:
        with self.assertRaises(common.LengthException):
            c.Tox_Pass_Key_Ptr(b"hello", b"world")

    def test_pass_encrypt_decrypt(self) -> None:
        self.assertNotEqual(c.pass_encrypt(b"hello world", b"hunter2"),
                            b"hello world")
        self.assertEqual(
            c.pass_decrypt(c.pass_encrypt(b"hello world", b"hunter2"),
                           b"hunter2"),
            b"hello world",
        )
        # wrong password should raise c.ApiException
        with self.assertRaises(c.ApiException) as ex:
            c.pass_decrypt(c.pass_encrypt(b"hello world", b"hunter2"),
                           b"hunter3")
        self.assertEqual(ex.exception.code, c.TOX_ERR_DECRYPTION_FAILED)

    def test_get_salt(self) -> None:
        salt = c.get_salt(c.pass_encrypt(b"hello world", b"hunter2"))
        self.assertEqual(len(salt), 32)
        with self.assertRaises(c.ApiException) as ex:
            c.get_salt(b"hello world" * 10)
        self.assertEqual(ex.exception.code, c.TOX_ERR_GET_SALT_BAD_FORMAT)
        with self.assertRaises(common.LengthException):
            c.get_salt(c.pass_encrypt(b"hello world", b"hunter2")[:79])


if __name__ == "__main__":
    unittest.main()

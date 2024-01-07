import unittest

import pytox.toxencryptsave.toxencryptsave as c


class ToxencryptsaveTest(unittest.TestCase):
    def test_encrypt_decrypt(self):
        with c.Tox_Pass_Key_Ptr(b"hello") as pk:
            self.assertNotEqual(pk.encrypt(b"hello world"), b"hello world")
            self.assertEqual(pk.decrypt(pk.encrypt(b"hello world")),
                             b"hello world")


if __name__ == "__main__":
    unittest.main()

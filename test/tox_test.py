import unittest

import pytox.toxcore.tox as c
from pytox import common
from typing import cast


class ToxTest(unittest.TestCase):
    def test_version(self) -> None:
        self.assertEqual(len(c.VERSION.split(".")), 3)

    def test_options(self) -> None:
        opts = c.Tox_Options_Ptr()
        self.assertTrue(opts.ipv6_enabled)
        opts.ipv6_enabled = False
        self.assertFalse(opts.ipv6_enabled)

    def test_use_after_free(self) -> None:
        opts = c.Tox_Options_Ptr()
        with c.Tox_Ptr(opts) as tox:
            saved_tox = tox
        with self.assertRaises(common.UseAfterFreeException):
            print(saved_tox.address)

    def test_pass_invalid_type(self) -> None:
        with self.assertRaises(TypeError):
            with c.Tox_Ptr(cast(c.Tox_Options_Ptr, "hello")) as tox:
                pass

    def test_pass_none(self) -> None:
        with c.Tox_Ptr(None) as tox:
            pass

    def test_address(self) -> None:
        opts = c.Tox_Options_Ptr()
        with c.Tox_Ptr(opts) as tox:
            self.assertEqual(tox.address, tox.address)

    def test_public_key_is_address_prefix(self) -> None:
        opts = c.Tox_Options_Ptr()
        with c.Tox_Ptr(opts) as tox:
            self.assertEqual(
                tox.public_key.hex()[:72] + format(tox.nospam, "08x"),
                tox.address[:36].hex(),
            )

    def test_public_key_is_not_secret_key(self) -> None:
        opts = c.Tox_Options_Ptr()
        with c.Tox_Ptr(opts) as tox:
            self.assertNotEqual(tox.public_key, tox.secret_key)

    def test_savedata_contains_secret_key(self) -> None:
        with c.Tox_Ptr() as tox:
            self.assertIn(tox.secret_key, tox.savedata)

    def test_set_name(self) -> None:
        with c.Tox_Ptr() as tox:
            self.assertEqual(tox.name, b"")
            tox.name = b"iphy"
            self.assertEqual(tox.name, b"iphy")

            tox.name = b"x" * c.MAX_NAME_LENGTH
            with self.assertRaises(c.ApiException):
                tox.name = b"x" * (c.MAX_NAME_LENGTH + 1)

    def test_set_status_message(self) -> None:
        with c.Tox_Ptr() as tox:
            self.assertEqual(tox.status_message, b"")
            tox.status_message = b"pytox is cool now"
            self.assertEqual(tox.status_message, b"pytox is cool now")

            tox.status_message = b"x" * c.MAX_STATUS_MESSAGE_LENGTH
            with self.assertRaises(c.ApiException):
                tox.status_message = b"x" * (c.MAX_STATUS_MESSAGE_LENGTH + 1)

    def test_set_status(self) -> None:
        with c.Tox_Ptr() as tox:
            self.assertEqual(tox.status, c.TOX_USER_STATUS_NONE)
            tox.status = c.TOX_USER_STATUS_AWAY
            self.assertEqual(tox.status, c.TOX_USER_STATUS_AWAY)
            tox.status = 50  # setting it to an invalid value has no effect
            self.assertEqual(tox.status, c.TOX_USER_STATUS_AWAY)

    def test_friend_add(self) -> None:
        with c.Tox_Ptr() as tox1:
            with c.Tox_Ptr() as tox2:
                tox1.friend_add(tox2.address, b"hello there!")
                tox2.friend_add_norequest(tox1.public_key)
                with self.assertRaises(common.LengthException):
                    tox2.friend_add(tox1.public_key, b"oh no!")

    def test_friend_delete(self) -> None:
        with c.Tox_Ptr() as tox1:
            with c.Tox_Ptr() as tox2:
                tox1.friend_add(tox2.address, b"hello there!")
                tox1.friend_delete(0)
                with self.assertRaises(c.ApiException):
                    # Deleting again: we don't have that friend anymore.
                    tox1.friend_delete(0)


if __name__ == "__main__":
    unittest.main()

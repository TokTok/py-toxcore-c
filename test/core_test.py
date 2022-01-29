import unittest

from pytox import core


class CoreTest(unittest.TestCase):
    def test_version(self):
        self.assertEqual(len(core.VERSION.split(".")), 3)

    def test_options(self):
        opts = core.ToxOptions()
        self.assertTrue(opts.ipv6_enabled)
        opts.ipv6_enabled = False
        self.assertFalse(opts.ipv6_enabled)

    def test_use_after_free(self):
        opts = core.ToxOptions()
        with self.assertRaises(core.UseAfterFreeException):
            with core.Core(opts) as tox:
                saved_tox = tox
            print(saved_tox.address)

    def test_address(self):
        opts = core.ToxOptions()
        with core.Core(opts) as tox:
            self.assertEqual(tox.address, tox.address)

    def test_public_key_is_address_prefix(self):
        opts = core.ToxOptions()
        with core.Core(opts) as tox:
            self.assertEqual(
                tox.public_key.hex()[:72] + format(tox.nospam, "08x"),
                tox.address[:36].hex(),
            )

    def test_public_key_is_not_secret_key(self):
        opts = core.ToxOptions()
        with core.Core(opts) as tox:
            self.assertNotEqual(tox.public_key, tox.secret_key)

    def test_savedata_contains_secret_key(self):
        with core.Core() as tox:
            self.assertIn(tox.secret_key, tox.savedata)

    def test_set_name(self):
        with core.Core() as tox:
            self.assertEqual(tox.name, b"")
            tox.name = b"iphy"
            self.assertEqual(tox.name, b"iphy")

            tox.name = b"x" * core.MAX_NAME_LENGTH
            with self.assertRaises(core.ApiException):
                tox.name = b"x" * (core.MAX_NAME_LENGTH + 1)

    def test_set_status_message(self):
        with core.Core() as tox:
            self.assertEqual(tox.status_message, b"")
            tox.status_message = b"pytox is cool now"
            self.assertEqual(tox.status_message, b"pytox is cool now")

            tox.status_message = b"x" * core.MAX_STATUS_MESSAGE_LENGTH
            with self.assertRaises(core.ApiException):
                tox.status_message = b"x" * (core.MAX_STATUS_MESSAGE_LENGTH +
                                             1)

    def test_set_status(self):
        with core.Core() as tox:
            self.assertEqual(tox.status, core.TOX_USER_STATUS_NONE)
            tox.status = core.TOX_USER_STATUS_AWAY
            self.assertEqual(tox.status, core.TOX_USER_STATUS_AWAY)
            tox.status = 50  # setting it to an invalid value has no effect
            self.assertEqual(tox.status, core.TOX_USER_STATUS_AWAY)

    def test_friend_add(self):
        with core.Core() as tox1:
            with core.Core() as tox2:
                tox1.friend_add(tox2.address, b"hello there!")
                tox2.friend_add_norequest(tox1.public_key)
                with self.assertRaises(core.LengthException):
                    tox2.friend_add_norequest(tox1.address)
                with self.assertRaises(core.LengthException):
                    tox2.friend_add(tox1.public_key, b"oh no!")

    def test_friend_delete(self):
        with core.Core() as tox1:
            with core.Core() as tox2:
                tox1.friend_add(tox2.address, b"hello there!")
                tox1.friend_delete(0)
                with self.assertRaises(core.ApiException):
                    # Deleting again: we don't have that friend anymore.
                    tox1.friend_delete(0)


if __name__ == "__main__":
    unittest.main()

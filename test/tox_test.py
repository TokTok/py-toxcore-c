import unittest
from typing import cast

import pytox.toxcore.tox as c
from pytox import common


class ToxTest(unittest.TestCase):

    def test_version(self) -> None:
        self.assertEqual(len(c.VERSION.split(".")), 3)

    def test_use_after_free(self) -> None:
        opts = c.Tox_Options_Ptr()
        with c.Tox_Ptr(opts) as tox:
            saved_tox = tox
        with self.assertRaises(common.UseAfterFreeException):
            print(saved_tox.address)

    def test_pass_invalid_type(self) -> None:
        with self.assertRaises(TypeError):
            with c.Tox_Ptr(cast(c.Tox_Options_Ptr, "hello")):
                pass

    def test_pass_none(self) -> None:
        with c.Tox_Ptr(None):
            pass

    def test_pass_invalid_options(self) -> None:
        opts = c.Tox_Options_Ptr()
        opts.proxy_type = c.TOX_PROXY_TYPE_SOCKS5
        opts.proxy_host = "invalid-host"
        opts.proxy_port = 1234
        with self.assertRaises(c.ApiException) as e:
            c.Tox_Ptr(opts)
        self.assertEqual(e.exception.code, c.TOX_ERR_NEW_PROXY_BAD_HOST)

    def test_address(self) -> None:
        opts = c.Tox_Options_Ptr()
        with c.Tox_Ptr(opts) as tox:
            self.assertEqual(tox.address, tox.address)

    def test_nospam(self) -> None:
        with c.Tox_Ptr(None) as tox:
            tox.nospam = 0x12345678
            self.assertEqual(tox.nospam, 0x12345678)
            self.assertEqual(tox.address[-6:-2].hex(), "12345678")

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
            # setting it to an invalid value has no effect
            tox.status = c.Tox_User_Status(50)
            self.assertEqual(tox.status, c.TOX_USER_STATUS_AWAY)

    def test_friend_add(self) -> None:
        with c.Tox_Ptr() as tox1:
            with c.Tox_Ptr() as tox2:
                tox1.friend_add(tox2.address, b"hello there!")
                tox2.friend_add_norequest(tox1.public_key)
                with self.assertRaises(common.LengthException):
                    tox2.friend_add(tox1.public_key, b"oh no!")

    def test_invalid_bootstrap(self) -> None:
        with c.Tox_Ptr() as tox:
            with self.assertRaises(c.ApiException) as e:
                tox.bootstrap("invalid-host", 1234, bytes(c.PUBLIC_KEY_SIZE))
            self.assertEqual(e.exception.code, c.TOX_ERR_BOOTSTRAP_BAD_HOST)

    def test_bootstrap_checks_key_length(self) -> None:
        with c.Tox_Ptr() as tox:
            with self.assertRaises(common.LengthException):
                tox.bootstrap("localhost", 1234, bytes(c.PUBLIC_KEY_SIZE - 1))

    def test_friend_delete(self) -> None:
        with c.Tox_Ptr() as tox1:
            with c.Tox_Ptr() as tox2:
                tox1.friend_add(tox2.address, b"hello there!")
                tox1.friend_delete(0)
                with self.assertRaises(c.ApiException):
                    # Deleting again: we don't have that friend anymore.
                    tox1.friend_delete(0)

    def test_udp_port_fails_when_udp_disabled(self) -> None:
        with c.Tox_Options_Ptr() as opts:
            opts.udp_enabled = False
            with c.Tox_Ptr(opts) as tox:
                with self.assertRaises(c.ApiException) as e:
                    print(tox.udp_port)
                self.assertEqual(e.exception.code,
                                 c.TOX_ERR_GET_PORT_NOT_BOUND)

    def test_tcp_port_fails_when_tcp_disabled(self) -> None:
        with c.Tox_Options_Ptr() as opts:
            opts.tcp_port = 0
            with c.Tox_Ptr(opts) as tox:
                with self.assertRaises(c.ApiException) as e:
                    print(tox.tcp_port)
                self.assertEqual(e.exception.code,
                                 c.TOX_ERR_GET_PORT_NOT_BOUND)

    def test_tcp_port(self) -> None:
        with c.Tox_Options_Ptr() as opts:
            opts.tcp_port = 1234
            with c.Tox_Ptr(opts) as tox:
                self.assertEqual(tox.tcp_port, 1234)


if __name__ == "__main__":
    unittest.main()

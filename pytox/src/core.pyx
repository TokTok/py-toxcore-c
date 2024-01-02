# cython: language_level=3
"""Toxcore bindings.
"""

from libcpp cimport bool
from libc.stdint cimport uint8_t, uint16_t, uint32_t, uint64_t
from libc.stdlib cimport malloc, free

from pytox import error
from pytox.options cimport Tox_Options, ToxOptions
from pytox.system cimport Tox_System

cdef extern from "tox/toxcore/tox.h": pass


VERSION: str = "%d.%d.%d" % (tox_version_major(), tox_version_minor(), tox_version_patch())

PUBLIC_KEY_SIZE: int = tox_public_key_size()
SECRET_KEY_SIZE: int = tox_secret_key_size()
CONFERENCE_UID_SIZE: int = tox_conference_uid_size()
CONFERENCE_ID_SIZE: int = tox_conference_id_size()
NOSPAM_SIZE: int = tox_nospam_size()
ADDRESS_SIZE: int = tox_address_size()
MAX_NAME_LENGTH: int = tox_max_name_length()
MAX_STATUS_MESSAGE_LENGTH: int = tox_max_status_message_length()
MAX_FRIEND_REQUEST_LENGTH: int = tox_max_friend_request_length()
MAX_MESSAGE_LENGTH: int = tox_max_message_length()
MAX_CUSTOM_PACKET_SIZE: int = tox_max_custom_packet_size()
HASH_LENGTH: int = tox_hash_length()
FILE_ID_LENGTH: int = tox_file_id_length()
MAX_FILENAME_LENGTH: int = tox_max_filename_length()
MAX_HOSTNAME_LENGTH: int = tox_max_hostname_length()


cdef void _check_len(str name, bytes data, int expected_length) except *:
    if len(data) != expected_length:
        raise error.LengthException(
                f"parameter '{name}' received bytes of invalid"
                f"length {len(data)}, expected {expected_length}")

cdef class Core:

    cdef Tox *_ptr

    def __init__(self, options: ToxOptions = None):
        err = TOX_ERR_NEW_OK
        if options is None:
            options = ToxOptions()
        self._ptr = tox_new(options._get(), &err)
        if err: raise error.ApiException(Tox_Err_New(err))

        install_handlers(self._get())

    def __dealloc__(self):
        self.__exit__(None, None, None)

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_value, exc_traceback):
        tox_kill(self._ptr)
        self._ptr = NULL

    cdef Tox *_get(self) except *:
        if self._ptr is NULL:
            raise error.UseAfterFreeException()
        return self._ptr

    @property
    def savedata(self) -> bytes:
        size = tox_get_savedata_size(self._get())
        data = <uint8_t*> malloc(size * sizeof(uint8_t))
        try:
            tox_get_savedata(self._get(), data)
            return data[:size]
        finally:
            free(data)

    def bootstrap(self, host: str, port: int, public_key: bytes) -> bool:
        _check_len("public_key", public_key, tox_public_key_size())
        err = TOX_ERR_BOOTSTRAP_OK
        return tox_bootstrap(self._get(), host.encode("utf-8"), port, public_key, &err)

    @property
    def connection_status(self) -> Tox_Connection:
        return Tox_Connection(tox_self_get_connection_status(self._get()))

    def handle_self_connection_status(self, connection_status: Tox_Connection) -> None:
        pass

    @property
    def iteration_interval(self) -> int:
        return tox_iteration_interval(self._get())

    def iterate(self) -> None:
        return tox_iterate(self._get(), <void*>self)

    @property
    def address(self) -> bytes:
        size = tox_address_size()
        data = <uint8_t*> malloc(size * sizeof(uint8_t))
        try:
            tox_self_get_address(self._get(), data)
            return data[:size]
        finally:
            free(data)

    @property
    def nospam(self) -> int:
        return tox_self_get_nospam(self._get())

    @property
    def public_key(self) -> bytes:
        size = tox_public_key_size()
        data = <uint8_t*> malloc(size * sizeof(uint8_t))
        try:
            tox_self_get_public_key(self._get(), data)
            return data[:tox_public_key_size()]
        finally:
            free(data)

    @property
    def secret_key(self) -> bytes:
        size = tox_secret_key_size()
        data = <uint8_t*> malloc(size * sizeof(uint8_t))
        try:
            tox_self_get_secret_key(self._get(), data)
            return data[:tox_secret_key_size()]
        finally:
            free(data)

    @property
    def name(self) -> bytes:
        size = tox_self_get_name_size(self._get())
        data = <uint8_t*> malloc(size * sizeof(uint8_t))
        try:
            tox_self_get_name(self._get(), data)
            return data[:size]
        finally:
            free(data)

    @name.setter
    def name(self, name: bytes) -> None:
        err = TOX_ERR_SET_INFO_OK
        tox_self_set_name(self._get(), name, len(name), &err)
        if err: raise error.ApiException(Tox_Err_Set_Info(err))

    @property
    def status_message(self) -> bytes:
        size = tox_self_get_status_message_size(self._get())
        data = <uint8_t*> malloc(size * sizeof(uint8_t))
        try:
            tox_self_get_status_message(self._get(), data)
            return data[:size]
        finally:
            free(data)

    @status_message.setter
    def status_message(self, status_message: bytes) -> None:
        err = TOX_ERR_SET_INFO_OK
        tox_self_set_status_message(self._get(), status_message, len(status_message), &err)
        if err: raise error.ApiException(Tox_Err_Set_Info(err))

    @property
    def status(self) -> Tox_User_Status:
        return tox_self_get_status(self._get())

    @status.setter
    def status(self, status: Tox_User_Status) -> None:
        tox_self_set_status(self._get(), status)

    def friend_add(self, address: bytes, message: bytes):
        _check_len("address", address, tox_address_size())
        err = TOX_ERR_FRIEND_ADD_OK
        tox_friend_add(self._get(), address, message, len(message), &err)
        if err: raise error.ApiException(Tox_Err_Friend_Add(err))

    def friend_add_norequest(self, public_key: bytes):
        _check_len("public_key", public_key, tox_public_key_size())
        err = TOX_ERR_FRIEND_ADD_OK
        tox_friend_add_norequest(self._get(), public_key, &err)
        if err: raise error.ApiException(Tox_Err_Friend_Add(err))

    def friend_delete(self, friend_number: int):
        err = TOX_ERR_FRIEND_DELETE_OK
        tox_friend_delete(self._get(), friend_number, &err)
        if err: raise error.ApiException(Tox_Err_Friend_Delete(err))

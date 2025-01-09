# cython: language_level=3, linetrace=True
from array import array
from pytox import common
from types import TracebackType
from typing import Optional
from typing import TypeVar

T = TypeVar("T")

class ApiException(common.ApiException):
    pass



cdef class Tox_Pass_Key_Ptr:
    cdef Tox_Pass_Key* _get(self) except *:
        if self._ptr is NULL:
            raise common.UseAfterFreeException()
        return self._ptr

    def __del__(self) -> None:
        self.__exit__(None, None, None)

    def __enter__(self: T) -> T:
        return self

    def __exit__(self, exc_type: type[BaseException] | None, exc_value: BaseException | None, exc_traceback: TracebackType | None) -> None:
        tox_pass_key_free(self._ptr)
        self._ptr = NULL

    cdef Tox_Pass_Key* _derive(self, bytes passphrase):
        cdef Tox_Err_Key_Derivation error = TOX_ERR_KEY_DERIVATION_OK
        cdef Tox_Pass_Key* ptr = tox_pass_key_derive(passphrase, len(passphrase), &error)
        if error:
            raise ApiException(Tox_Err_Key_Derivation(error))
        return ptr

    cdef Tox_Pass_Key* _derive_with_salt(self, bytes passphrase, bytes salt):
        common.check_len("salt", salt, tox_pass_salt_length())
        cdef Tox_Err_Key_Derivation error = TOX_ERR_KEY_DERIVATION_OK
        cdef Tox_Pass_Key* ptr = tox_pass_key_derive_with_salt(passphrase, len(passphrase), common.check_len("salt", salt, tox_pass_salt_length()), &error)
        if error:
            raise ApiException(Tox_Err_Key_Derivation(error))
        return ptr

    #
    # Manual
    #

    def __init__(self, passphrase: bytes, salt: Optional[bytes] = None):
        """Create new Tox_Pass_Key object."""
        if salt:
            self._ptr = self._derive_with_salt(passphrase, salt)
        else:
            self._ptr = self._derive(passphrase)

    def encrypt(self, plaintext: bytes) -> bytes:
        cdef Tox_Err_Encryption err = TOX_ERR_ENCRYPTION_OK
        cdef size_t size = len(plaintext) + tox_pass_encryption_extra_length()
        cdef uint8_t *ciphertext = <uint8_t*> malloc(size * sizeof(uint8_t))
        try:
            tox_pass_key_encrypt(self._get(), plaintext, len(plaintext), ciphertext, &err)
            if err:
                raise ApiException(Tox_Err_Encryption(err))
            return ciphertext[:size]
        finally:
            free(ciphertext)

    def decrypt(self, ciphertext: bytes) -> bytes:
        common.check_len("ciphertext", ciphertext, tox_pass_encryption_extra_length())
        cdef Tox_Err_Decryption err = TOX_ERR_DECRYPTION_OK
        cdef size_t size = len(ciphertext) - tox_pass_encryption_extra_length()
        cdef uint8_t *plaintext = <uint8_t*> malloc(size * sizeof(uint8_t))
        try:
            tox_pass_key_decrypt(self._get(), ciphertext, len(ciphertext), plaintext, &err)
            if err:
                raise ApiException(Tox_Err_Decryption(err))
            return plaintext[:size]
        finally:
            free(plaintext)


def pass_encrypt(plaintext: bytes, passphrase: bytes) -> bytes:
    cdef Tox_Err_Encryption err = Tox_Err_Encryption.TOX_ERR_ENCRYPTION_OK
    cdef size_t size = len(plaintext) + tox_pass_encryption_extra_length()
    cdef uint8_t *ciphertext = <uint8_t*> malloc(size * sizeof(uint8_t))
    try:
        tox_pass_encrypt(plaintext, len(plaintext), passphrase, len(passphrase), ciphertext, &err)
        if err:
            raise ApiException(Tox_Err_Encryption(err))
        return ciphertext[:size]
    finally:
        free(ciphertext)


def pass_decrypt(ciphertext: bytes, passphrase: bytes) -> bytes:
    common.check_len("ciphertext", ciphertext, tox_pass_encryption_extra_length())
    cdef Tox_Err_Decryption err = Tox_Err_Decryption.TOX_ERR_DECRYPTION_OK
    cdef size_t size = len(ciphertext) - tox_pass_encryption_extra_length()
    cdef uint8_t *plaintext = <uint8_t*> malloc(size * sizeof(uint8_t))
    try:
        tox_pass_decrypt(ciphertext, len(ciphertext), passphrase, len(passphrase), plaintext, &err)
        if err:
            raise ApiException(Tox_Err_Decryption(err))
        return plaintext[:size]
    finally:
        free(plaintext)


def get_salt(ciphertext: bytes) -> bytes:
    common.check_len("ciphertext", ciphertext, tox_pass_encryption_extra_length())
    cdef Tox_Err_Get_Salt err = Tox_Err_Get_Salt.TOX_ERR_GET_SALT_OK
    cdef uint8_t *salt = <uint8_t*> malloc(tox_pass_salt_length() * sizeof(uint8_t))
    try:
        tox_get_salt(ciphertext, salt, &err)
        if err:
            raise ApiException(Tox_Err_Get_Salt(err))
        return salt[:tox_pass_salt_length()]
    finally:
        free(salt)


def is_data_encrypted(data: bytes) -> bool:
    return tox_is_data_encrypted(data)

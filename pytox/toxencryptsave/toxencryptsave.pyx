# cython: language_level=3

class ToxencryptsaveException(Exception):
    pass

class ApiException(ToxencryptsaveException):
    def __init__(self, err):
        super().__init__(err)
        self.error = err

class LengthException(ToxencryptsaveException):
    pass

class UseAfterFreeException(Exception):
    def __init__(self):
        super().__init__(
                "object used after it was killed/freed (or it was never initialised)")

cdef class Tox_Pass_Key_Ptr:

    cdef Tox_Pass_Key* _get(self) except *:
        if self._ptr is NULL:
            raise UseAfterFreeException()
        return self._ptr

    @staticmethod
    cdef Tox_Pass_Key* _derive(bytes passphrase):
        cdef Tox_Err_Key_Derivation err = TOX_ERR_KEY_DERIVATION_OK
        cdef Tox_Pass_Key* ptr = tox_pass_key_derive(passphrase, len(passphrase), &err)
        if err: raise ApiException(Tox_Err_Key_Derivation(err))
        return ptr

    @staticmethod
    cdef Tox_Pass_Key* _derive_with_salt(bytes passphrase, bytes salt):
        cdef Tox_Err_Key_Derivation err = TOX_ERR_KEY_DERIVATION_OK
        cdef Tox_Pass_Key* ptr = tox_pass_key_derive_with_salt(passphrase, len(passphrase), salt, &err)
        if err: raise ApiException(Tox_Err_Key_Derivation(err))
        return ptr

    def __init__(self, passphrase: bytes, salt: bytes = None):
        if salt:
            self._ptr = Tox_Pass_Key_Ptr._derive_with_salt(passphrase, salt)
        else:
            self._ptr = Tox_Pass_Key_Ptr._derive(passphrase)

    def __dealloc__(self):
        self.__exit__(None, None, None)

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_value, exc_traceback):
        tox_pass_key_free(self._ptr)
        self._ptr = NULL

    def encrypt(self, plaintext: bytes) -> bytes:
        cdef Tox_Err_Encryption err = TOX_ERR_ENCRYPTION_OK
        cdef size_t size = len(plaintext) + tox_pass_encryption_extra_length()
        cdef uint8_t *ciphertext = <uint8_t*> malloc(size * sizeof(uint8_t))
        try:
            tox_pass_key_encrypt(self._get(), plaintext, len(plaintext), ciphertext, &err)
            if err: raise ApiException(Tox_Err_Encryption(err))
            return ciphertext[:size]
        finally:
            free(ciphertext)

    def decrypt(self, ciphertext: bytes) -> bytes:
        cdef Tox_Err_Decryption err = TOX_ERR_DECRYPTION_OK
        cdef size_t size = len(ciphertext) - tox_pass_encryption_extra_length()
        cdef uint8_t *plaintext = <uint8_t*> malloc(size * sizeof(uint8_t))
        try:
            tox_pass_key_decrypt(self._get(), ciphertext, len(ciphertext), plaintext, &err)
            if err: raise ApiException(Tox_Err_Decryption(err))
            return plaintext[:size]
        finally:
            free(plaintext)

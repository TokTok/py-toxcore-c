# pytox.toxencryptsave.toxencryptsave
from types import TracebackType
from typing import Optional
from typing import TypeVar
import enum
import pytox.common
T = TypeVar("T")
class ApiException(pytox.common.ApiException): ...
class Tox_Err_Decryption(enum.Enum): ...
class Tox_Err_Encryption(enum.Enum): ...
class Tox_Err_Get_Salt(enum.Enum): ...
class Tox_Err_Key_Derivation(enum.Enum): ...
class Tox_Pass_Key_Ptr:
    def __enter__(self: T) -> T: ...
    def __exit__(self, exc_type: type[BaseException] | None, exc_value: BaseException | None, exc_traceback: TracebackType | None) -> None: ...
    def __init__(self, passphrase: bytes, salt: Optional[bytes] = None) -> None: ...
    def decrypt(self, ciphertext: bytes) -> bytes: ...
    def encrypt(self, plaintext: bytes) -> bytes: ...
TOX_ERR_DECRYPTION_BAD_FORMAT: Tox_Err_Decryption
TOX_ERR_DECRYPTION_FAILED: Tox_Err_Decryption
TOX_ERR_DECRYPTION_INVALID_LENGTH: Tox_Err_Decryption
TOX_ERR_DECRYPTION_KEY_DERIVATION_FAILED: Tox_Err_Decryption
TOX_ERR_DECRYPTION_NULL: Tox_Err_Decryption
TOX_ERR_DECRYPTION_OK: Tox_Err_Decryption
TOX_ERR_ENCRYPTION_FAILED: Tox_Err_Encryption
TOX_ERR_ENCRYPTION_KEY_DERIVATION_FAILED: Tox_Err_Encryption
TOX_ERR_ENCRYPTION_NULL: Tox_Err_Encryption
TOX_ERR_ENCRYPTION_OK: Tox_Err_Encryption
TOX_ERR_GET_SALT_BAD_FORMAT: Tox_Err_Get_Salt
TOX_ERR_GET_SALT_NULL: Tox_Err_Get_Salt
TOX_ERR_GET_SALT_OK: Tox_Err_Get_Salt
TOX_ERR_KEY_DERIVATION_FAILED: Tox_Err_Key_Derivation
TOX_ERR_KEY_DERIVATION_NULL: Tox_Err_Key_Derivation
TOX_ERR_KEY_DERIVATION_OK: Tox_Err_Key_Derivation

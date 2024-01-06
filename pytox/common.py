from enum import Enum
from typing import Sized
from typing import TypeVar

T = TypeVar("T", bytes, str, Sized)


class PytoxException(Exception):
    pass


class ApiException(PytoxException):
    def __init__(self, err: Enum):
        super().__init__(err.name)
        self.error = err


class LengthException(PytoxException):
    pass


class UseAfterFreeException(Exception):
    def __init__(self):
        super().__init__(
            "object used after it was killed/freed (or it was never initialised)"
        )


def _check_len(name: str, data: T, expected_length: int) -> T:
    if len(data) < expected_length:
        raise LengthException(
            f"parameter '{name}' received bytes of invalid"
            f"length {len(data)}, expected at least {expected_length}")
    return data

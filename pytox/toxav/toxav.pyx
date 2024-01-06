# cython: language_level=3

from pytox.toxcore import tox

def foo() -> str:
    tox.VERSION

class ToxavException(Exception):
    pass

class ApiException(ToxavException):
    def __init__(self, err):
        super().__init__(err)
        self.error = err

class LengthException(ToxavException):
    pass

class UseAfterFreeException(Exception):
    def __init__(self):
        super().__init__(
                "object used after it was killed/freed (or it was never initialised)")

cdef class Toxav_Ptr:

    cdef Toxav* _get(self) except *:
        if self._ptr is NULL:
            raise UseAfterFreeException()
        return self._ptr

    @staticmethod
    cdef Toxav* _new(tox: tox.Tox_Ptr):
        cdef Toxav_Err_New err = TOXAV_ERR_NEW_OK
        cdef Toxav* ptr = toxav_new(tox._get() if tox else NULL, &err)
        if err: raise ApiException(Toxav_Err_New(err))
        # install_handlers(ptr)
        return ptr

    def __dealloc__(self):
        self.__exit__(None, None, None)

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_value, exc_traceback):
        toxav_kill(self._ptr)
        self._ptr = NULL

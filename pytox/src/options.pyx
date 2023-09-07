# cython: language_level=3
"""Toxcore bindings.
"""

from libcpp cimport bool
from libc.stdint cimport uint8_t, uint16_t, uint32_t, uint64_t

from pytox import error
from pytox.log cimport Tox_Log_Level
from pytox.system cimport Tox_System

cdef extern from "tox/toxcore/tox_options.h": pass


cdef class ToxOptions:

    def __init__(self):
        err = TOX_ERR_OPTIONS_NEW_OK
        self._ptr = tox_options_new(&err)
        if err: raise error.ApiException(Tox_Err_Options_New(err))

    def __dealloc__(self):
        self.__exit__(None, None, None)

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_value, exc_traceback):
        tox_options_free(self._ptr)
        self._ptr = NULL

    cdef Tox_Options *_get(self) except *:
        if self._ptr is NULL:
            raise error.UseAfterFreeException()
        return self._ptr

    @property
    def ipv6_enabled(self) -> bool:
        return tox_options_get_ipv6_enabled(self._get())

    @ipv6_enabled.setter
    def ipv6_enabled(self, value: bool):
        tox_options_set_ipv6_enabled(self._get(), value)



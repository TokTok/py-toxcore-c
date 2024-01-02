# cython: language_level=3
"""Toxcore bindings.
"""

from libcpp cimport bool
from libc.stdint cimport uint8_t, uint16_t, uint32_t, uint64_t

from pytox import error

cdef extern from "tox/toxcore/tox_memory.h": pass


cdef class ToxMemory:

    def __init__(self):
        self._ptr = tox_memory_new(NULL, <void*>self)
        if self._ptr is NULL: raise MemoryError("tox_memory_new")

    def __dealloc__(self):
        self.__exit__(None, None, None)

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_value, exc_traceback):
        tox_memory_free(self._ptr)
        self._ptr = NULL

    cdef Tox_Memory *_get(self) except *:
        if self._ptr is NULL:
            raise error.UseAfterFreeException()
        return self._ptr

# cython: language_level=3
"""Toxcore bindings.
"""

from libcpp cimport bool
from libc.stdint cimport uint8_t, uint16_t, uint32_t, uint64_t

from pytox import error
from pytox cimport memory
from pytox.memory cimport Tox_Memory

cdef extern from "tox/toxcore/tox_random.h": pass


cdef class ToxRandom:

    def __init__(self, memory.ToxMemory mem):
        self._ptr = tox_random_new(NULL, <void*>self, mem._get())
        if self._ptr is NULL: raise MemoryError("tox_random_new")

    def __dealloc__(self):
        self.__exit__(None, None, None)

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_value, exc_traceback):
        tox_random_free(self._ptr)
        self._ptr = NULL

    cdef Tox_Random *_get(self) except *:
        if self._ptr is NULL:
            raise error.UseAfterFreeException()
        return self._ptr

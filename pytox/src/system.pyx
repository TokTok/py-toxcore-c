# cython: language_level=3
"""Toxcore bindings.
"""

from libcpp cimport bool
from libc.stdint cimport uint8_t, uint16_t, uint32_t, uint64_t

from pytox import error
from pytox.log cimport Tox_Log
from pytox.memory cimport Tox_Memory
from pytox.network cimport Tox_Network
from pytox.random cimport Tox_Random
from pytox.time cimport Tox_Time

cdef extern from "tox/toxcore/tox_system.h": pass


cdef class ToxSystem:

    def __init__(self):
        sys = os_system()
        self._ptr = tox_system_new(
                tox_system_get_log(sys),
                tox_system_get_memory(sys),
                tox_system_get_network(sys),
                tox_system_get_random(sys),
                tox_system_get_time(sys))
        if self._ptr is NULL: raise MemoryError("tox_system_new")

    def __dealloc__(self):
        self.__exit__(None, None, None)

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_value, exc_traceback):
        tox_system_free(self._ptr)
        self._ptr = NULL

    cdef Tox_System *_get(self) except *:
        if self._ptr is NULL:
            raise error.UseAfterFreeException()
        return self._ptr

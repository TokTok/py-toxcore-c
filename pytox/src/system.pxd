from pytox.log cimport Tox_Log
from pytox.memory cimport Tox_Memory
from pytox.network cimport Tox_Network
from pytox.random cimport Tox_Random
from pytox.time cimport Tox_Time

cdef extern from "tox/toxcore/tox_system.h":
    ctypedef struct Tox_System

cdef extern from "tox/toxcore/os_system.h": pass

cdef class ToxSystem:

    cdef Tox_System *_ptr

    cdef Tox_System *_get(self) except *

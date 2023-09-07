cdef extern from "tox/toxcore/tox_memory.h":
    ctypedef struct Tox_Memory

cdef extern from "tox/toxcore/os_memory.h": pass

cdef class ToxMemory:

    cdef Tox_Memory *_ptr

    cdef Tox_Memory *_get(self) except *

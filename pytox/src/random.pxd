cdef extern from "tox/toxcore/tox_random.h":
    ctypedef struct Tox_Random

cdef extern from "tox/toxcore/os_random.h": pass

cdef class ToxRandom:

    cdef Tox_Random *_ptr

    cdef Tox_Random *_get(self) except *

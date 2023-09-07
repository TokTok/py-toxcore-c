cdef extern from "tox/toxcore/tox_time.h":
    ctypedef struct Tox_Time

cdef class ToxTime:

    cdef Tox_Time *_ptr

    cdef Tox_Time *_get(self) except *

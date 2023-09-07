cdef extern from "tox/toxcore/tox_options.h":
    cdef struct Tox_Options

cdef class ToxOptions:

    cdef Tox_Options *_ptr

    cdef Tox_Options *_get(self) except *

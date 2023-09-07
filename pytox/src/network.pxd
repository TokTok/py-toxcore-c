cdef extern from "tox/toxcore/tox_network.h":
    ctypedef struct Tox_Network

cdef extern from "tox/toxcore/os_network.h": pass

cdef class ToxNetwork:

    cdef Tox_Network *_ptr

    cdef Tox_Network *_get(self) except *

# cython: language_level=3
cdef extern from "tox/toxcore/tox_log.h":
    ctypedef struct Tox_Log

    cpdef enum Tox_Log_Level:
        TOX_LOG_LEVEL_TRACE,
        TOX_LOG_LEVEL_DEBUG,
        TOX_LOG_LEVEL_INFO,
        TOX_LOG_LEVEL_WARNING,
        TOX_LOG_LEVEL_ERROR,

cdef extern from "tox/toxcore/os_log.h": pass

cdef class ToxLog:

    cdef Tox_Log *_ptr

    cdef Tox_Log *_get(self) except *

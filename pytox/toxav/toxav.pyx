# cython: language_level=3, linetrace=True
from array import array
from pytox import common
from types import TracebackType
from typing import TypeVar

T = TypeVar("T")


class ApiException(common.ApiException):
    pass


cdef:
    void py_handle_call(self: Toxav_Ptr, friend_number: int, audio_enabled: bool, video_enabled: bool) except *:
        self.handle_call(friend_number, audio_enabled, video_enabled)
    void handle_call(Toxav* av, uint32_t friend_number, bool audio_enabled, bool video_enabled, void* user_data) except *:
        py_handle_call(<Toxav_Ptr> user_data, friend_number, audio_enabled, video_enabled)
    void py_handle_call_state(self: Toxav_Ptr, friend_number: int, state: int) except *:
        self.handle_call_state(friend_number, state)
    void handle_call_state(Toxav* av, uint32_t friend_number, uint32_t state, void* user_data) except *:
        py_handle_call_state(<Toxav_Ptr> user_data, friend_number, state)
    void py_handle_audio_bit_rate(self: Toxav_Ptr, friend_number: int, audio_bit_rate: int) except *:
        self.handle_audio_bit_rate(friend_number, audio_bit_rate)
    void handle_audio_bit_rate(Toxav* av, uint32_t friend_number, uint32_t audio_bit_rate, void* user_data) except *:
        py_handle_audio_bit_rate(<Toxav_Ptr> user_data, friend_number, audio_bit_rate)
    void py_handle_audio_receive_frame(self: Toxav_Ptr, friend_number: int, pcm: array, channels: int, sampling_rate: int) except *:
        self.handle_audio_receive_frame(friend_number, pcm, channels, sampling_rate)
    void handle_audio_receive_frame(Toxav* av, uint32_t friend_number, const int16_t* pcm, size_t sample_count, uint8_t channels, uint32_t sampling_rate, void* user_data) except *:
        py_handle_audio_receive_frame(<Toxav_Ptr> user_data, friend_number, array("h", [x for x in pcm[:sample_count]]), channels, sampling_rate)
    void py_handle_video_bit_rate(self: Toxav_Ptr, friend_number: int, video_bit_rate: int) except *:
        self.handle_video_bit_rate(friend_number, video_bit_rate)
    void handle_video_bit_rate(Toxav* av, uint32_t friend_number, uint32_t video_bit_rate, void* user_data) except *:
        py_handle_video_bit_rate(<Toxav_Ptr> user_data, friend_number, video_bit_rate)
    void py_handle_video_receive_frame(self: Toxav_Ptr, friend_number: int, width: int, height: int, y: bytes, u: bytes, v: bytes, ystride: int, ustride: int, vstride: int) except *:
        self.handle_video_receive_frame(friend_number, width, height, y, u, v, ystride, ustride, vstride)
    void handle_video_receive_frame(Toxav* av, uint32_t friend_number, uint16_t width, uint16_t height, const uint8_t* y, const uint8_t* u, const uint8_t* v, int32_t ystride, int32_t ustride, int32_t vstride, void* user_data) except *:
        py_handle_video_receive_frame(<Toxav_Ptr> user_data, friend_number, width, height, y[:max(width, abs(ystride)) * height], u[:max(width / 2, abs(ustride)) * (height / 2)], v[:max(width / 2, abs(vstride)) * (height / 2)], ystride, ustride, vstride)

    void install_handlers(Toxav_Ptr self, Toxav* ptr):
        toxav_callback_call(ptr, handle_call, <void*>self)
        toxav_callback_call_state(ptr, handle_call_state, <void*>self)
        toxav_callback_audio_bit_rate(ptr, handle_audio_bit_rate, <void*>self)
        toxav_callback_audio_receive_frame(ptr, handle_audio_receive_frame, <void*>self)
        toxav_callback_video_bit_rate(ptr, handle_video_bit_rate, <void*>self)
        toxav_callback_video_receive_frame(ptr, handle_video_receive_frame, <void*>self)


cdef class Toxav_Ptr:
    cdef Toxav* _get(self) except *:
        if self._ptr is NULL:
            raise common.UseAfterFreeException()
        return self._ptr

    def __dealloc__(self) -> None:
        self.__exit__(None, None, None)

    def __enter__(self: T) -> T:
        return self

    cdef Toxav* _new(self, tox.Tox_Ptr tox):
        cdef Toxav_Err_New error = TOXAV_ERR_NEW_OK
        cdef Toxav* ptr = toxav_new(tox._get() if tox else NULL, &error)
        if error:
            raise ApiException(Toxav_Err_New(error))
        return ptr

    def __exit__(self, exc_type: type[BaseException] | None, exc_value: BaseException | None, exc_traceback: TracebackType | None) -> None:
        toxav_kill(self._ptr)
        self._ptr = NULL

    def handle_call(self, friend_number: int, audio_enabled: bool, video_enabled: bool) -> None: pass
    def handle_call_state(self, friend_number: int, state: int) -> None: pass
    def handle_audio_bit_rate(self, friend_number: int, audio_bit_rate: int) -> None: pass
    def handle_audio_receive_frame(self, friend_number: int, pcm: array, channels: int, sampling_rate: int) -> None: pass
    def handle_video_bit_rate(self, friend_number: int, video_bit_rate: int) -> None: pass
    def handle_video_receive_frame(self, friend_number: int, width: int, height: int, y: bytes, u: bytes, v: bytes, ystride: int, ustride: int, vstride: int) -> None: pass

    def __init__(self, tox.Tox_Ptr tox):
        """Create new Toxav object."""
        self._ptr = self._new(tox)
        install_handlers(self, self._ptr)

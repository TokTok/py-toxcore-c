# pytox.toxav.toxav
from array import array
from pytox.toxcore.tox import Tox_Ptr
from types import TracebackType
from typing import Any
from typing import TypeVar
import enum
import pytox.common
T = TypeVar("T")
class ApiException(pytox.common.ApiException): ...
class Toxav_Call_Control(enum.Enum): ...
class Toxav_Err_Answer(enum.Enum): ...
class Toxav_Err_Bit_Rate_Set(enum.Enum): ...
class Toxav_Err_Call(enum.Enum): ...
class Toxav_Err_Call_Control(enum.Enum): ...
class Toxav_Err_New(enum.Enum): ...
class Toxav_Err_Send_Frame(enum.Enum): ...
class Toxav_Friend_Call_State(enum.Enum): ...
class Toxav_Ptr:
    def __enter__(self: T) -> T: ...
    def __exit__(self, exc_type: type[BaseException] | None, exc_value: BaseException | None, exc_traceback: TracebackType | None) -> None: ...
    def __init__(self, tox: Tox_Ptr) -> None: ...
    def handle_audio_bit_rate(self, friend_number: int, audio_bit_rate: int) -> None: ...
    def handle_audio_receive_frame(self, friend_number: int, pcm: array[Any], channels: int, sampling_rate: int) -> None: ...
    def handle_call(self, friend_number: int, audio_enabled: bool, video_enabled: bool) -> None: ...
    def handle_call_state(self, friend_number: int, state: int) -> None: ...
    def handle_video_bit_rate(self, friend_number: int, video_bit_rate: int) -> None: ...
    def handle_video_receive_frame(self, friend_number: int, width: int, height: int, y: bytes, u: bytes, v: bytes, ystride: int, ustride: int, vstride: int) -> None: ...
TOXAV_CALL_CONTROL_CANCEL: Toxav_Call_Control
TOXAV_CALL_CONTROL_HIDE_VIDEO: Toxav_Call_Control
TOXAV_CALL_CONTROL_MUTE_AUDIO: Toxav_Call_Control
TOXAV_CALL_CONTROL_PAUSE: Toxav_Call_Control
TOXAV_CALL_CONTROL_RESUME: Toxav_Call_Control
TOXAV_CALL_CONTROL_SHOW_VIDEO: Toxav_Call_Control
TOXAV_CALL_CONTROL_UNMUTE_AUDIO: Toxav_Call_Control
TOXAV_ERR_ANSWER_CODEC_INITIALIZATION: Toxav_Err_Answer
TOXAV_ERR_ANSWER_FRIEND_NOT_CALLING: Toxav_Err_Answer
TOXAV_ERR_ANSWER_FRIEND_NOT_FOUND: Toxav_Err_Answer
TOXAV_ERR_ANSWER_INVALID_BIT_RATE: Toxav_Err_Answer
TOXAV_ERR_ANSWER_OK: Toxav_Err_Answer
TOXAV_ERR_ANSWER_SYNC: Toxav_Err_Answer
TOXAV_ERR_BIT_RATE_SET_FRIEND_NOT_FOUND: Toxav_Err_Bit_Rate_Set
TOXAV_ERR_BIT_RATE_SET_FRIEND_NOT_IN_CALL: Toxav_Err_Bit_Rate_Set
TOXAV_ERR_BIT_RATE_SET_INVALID_BIT_RATE: Toxav_Err_Bit_Rate_Set
TOXAV_ERR_BIT_RATE_SET_OK: Toxav_Err_Bit_Rate_Set
TOXAV_ERR_BIT_RATE_SET_SYNC: Toxav_Err_Bit_Rate_Set
TOXAV_ERR_CALL_CONTROL_FRIEND_NOT_FOUND: Toxav_Err_Call
TOXAV_ERR_CALL_CONTROL_FRIEND_NOT_IN_CALL: Toxav_Err_Call
TOXAV_ERR_CALL_CONTROL_INVALID_TRANSITION: Toxav_Err_Call
TOXAV_ERR_CALL_CONTROL_OK: Toxav_Err_Call
TOXAV_ERR_CALL_CONTROL_SYNC: Toxav_Err_Call
TOXAV_ERR_CALL_FRIEND_ALREADY_IN_CALL: Toxav_Err_Call
TOXAV_ERR_CALL_FRIEND_NOT_CONNECTED: Toxav_Err_Call
TOXAV_ERR_CALL_FRIEND_NOT_FOUND: Toxav_Err_Call
TOXAV_ERR_CALL_INVALID_BIT_RATE: Toxav_Err_Call
TOXAV_ERR_CALL_MALLOC: Toxav_Err_Call
TOXAV_ERR_CALL_OK: Toxav_Err_Call
TOXAV_ERR_CALL_SYNC: Toxav_Err_Call
TOXAV_ERR_NEW_MALLOC: Toxav_Err_New
TOXAV_ERR_NEW_MULTIPLE: Toxav_Err_New
TOXAV_ERR_NEW_NULL: Toxav_Err_New
TOXAV_ERR_NEW_OK: Toxav_Err_New
TOXAV_ERR_SEND_FRAME_FRIEND_NOT_FOUND: Toxav_Err_Send_Frame
TOXAV_ERR_SEND_FRAME_FRIEND_NOT_IN_CALL: Toxav_Err_Send_Frame
TOXAV_ERR_SEND_FRAME_INVALID: Toxav_Err_Send_Frame
TOXAV_ERR_SEND_FRAME_NULL: Toxav_Err_Send_Frame
TOXAV_ERR_SEND_FRAME_OK: Toxav_Err_Send_Frame
TOXAV_ERR_SEND_FRAME_PAYLOAD_TYPE_DISABLED: Toxav_Err_Send_Frame
TOXAV_ERR_SEND_FRAME_RTP_FAILED: Toxav_Err_Send_Frame
TOXAV_ERR_SEND_FRAME_SYNC: Toxav_Err_Send_Frame
TOXAV_FRIEND_CALL_STATE_ACCEPTING_A: Toxav_Friend_Call_State
TOXAV_FRIEND_CALL_STATE_ACCEPTING_V: Toxav_Friend_Call_State
TOXAV_FRIEND_CALL_STATE_ERROR: Toxav_Friend_Call_State
TOXAV_FRIEND_CALL_STATE_FINISHED: Toxav_Friend_Call_State
TOXAV_FRIEND_CALL_STATE_NONE: Toxav_Friend_Call_State
TOXAV_FRIEND_CALL_STATE_SENDING_A: Toxav_Friend_Call_State
TOXAV_FRIEND_CALL_STATE_SENDING_V: Toxav_Friend_Call_State

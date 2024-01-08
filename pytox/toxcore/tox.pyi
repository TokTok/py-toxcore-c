# pytox.toxcore.tox
from types import TracebackType
from typing import Any
from typing import Optional
from typing import Self
import enum
import pytox.common
class Tox_Conference_Number: ...
class Tox_Conference_Peer_Number: ...
class Tox_File_Number: ...
class Tox_Friend_Message_Id: ...
class Tox_Friend_Number: ...
class Tox_Group_Message_Id: ...
class Tox_Group_Number: ...
class Tox_Group_Peer_Number: ...
class ApiException(pytox.common.ApiException): ...
class Tox_Conference_Type(enum.Enum): ...
class Tox_Connection(enum.Enum): ...
class Tox_Err_Bootstrap(enum.Enum): ...
class Tox_Err_Conference_By_Id(enum.Enum): ...
class Tox_Err_Conference_By_Uid(enum.Enum): ...
class Tox_Err_Conference_Delete(enum.Enum): ...
class Tox_Err_Conference_Get_Type(enum.Enum): ...
class Tox_Err_Conference_Invite(enum.Enum): ...
class Tox_Err_Conference_Join(enum.Enum): ...
class Tox_Err_Conference_New(enum.Enum): ...
class Tox_Err_Conference_Peer_Query(enum.Enum): ...
class Tox_Err_Conference_Send_Message(enum.Enum): ...
class Tox_Err_Conference_Set_Max_Offline(enum.Enum): ...
class Tox_Err_Conference_Title(enum.Enum): ...
class Tox_Err_File_Control(enum.Enum): ...
class Tox_Err_File_Get(enum.Enum): ...
class Tox_Err_File_Seek(enum.Enum): ...
class Tox_Err_File_Send(enum.Enum): ...
class Tox_Err_File_Send_Chunk(enum.Enum): ...
class Tox_Err_Friend_Add(enum.Enum): ...
class Tox_Err_Friend_By_Public_Key(enum.Enum): ...
class Tox_Err_Friend_Custom_Packet(enum.Enum): ...
class Tox_Err_Friend_Delete(enum.Enum): ...
class Tox_Err_Friend_Get_Last_Online(enum.Enum): ...
class Tox_Err_Friend_Get_Public_Key(enum.Enum): ...
class Tox_Err_Friend_Query(enum.Enum): ...
class Tox_Err_Friend_Send_Message(enum.Enum): ...
class Tox_Err_Get_Port(enum.Enum): ...
class Tox_Err_Group_Disconnect(enum.Enum): ...
class Tox_Err_Group_Founder_Set_Password(enum.Enum): ...
class Tox_Err_Group_Founder_Set_Peer_Limit(enum.Enum): ...
class Tox_Err_Group_Founder_Set_Privacy_State(enum.Enum): ...
class Tox_Err_Group_Founder_Set_Topic_Lock(enum.Enum): ...
class Tox_Err_Group_Founder_Set_Voice_State(enum.Enum): ...
class Tox_Err_Group_Invite_Accept(enum.Enum): ...
class Tox_Err_Group_Invite_Friend(enum.Enum): ...
class Tox_Err_Group_Is_Connected(enum.Enum): ...
class Tox_Err_Group_Join(enum.Enum): ...
class Tox_Err_Group_Leave(enum.Enum): ...
class Tox_Err_Group_Mod_Kick_Peer(enum.Enum): ...
class Tox_Err_Group_Mod_Set_Role(enum.Enum): ...
class Tox_Err_Group_New(enum.Enum): ...
class Tox_Err_Group_Peer_Query(enum.Enum): ...
class Tox_Err_Group_Reconnect(enum.Enum): ...
class Tox_Err_Group_Self_Name_Set(enum.Enum): ...
class Tox_Err_Group_Self_Query(enum.Enum): ...
class Tox_Err_Group_Self_Status_Set(enum.Enum): ...
class Tox_Err_Group_Send_Custom_Packet(enum.Enum): ...
class Tox_Err_Group_Send_Custom_Private_Packet(enum.Enum): ...
class Tox_Err_Group_Send_Message(enum.Enum): ...
class Tox_Err_Group_Send_Private_Message(enum.Enum): ...
class Tox_Err_Group_Set_Ignore(enum.Enum): ...
class Tox_Err_Group_State_Queries(enum.Enum): ...
class Tox_Err_Group_Topic_Set(enum.Enum): ...
class Tox_Err_New(enum.Enum): ...
class Tox_Err_Options_New(enum.Enum): ...
class Tox_Err_Set_Info(enum.Enum): ...
class Tox_Err_Set_Typing(enum.Enum): ...
class Tox_File_Control(enum.Enum): ...
class Tox_File_Kind(enum.Enum): ...
class Tox_Group_Exit_Type(enum.Enum): ...
class Tox_Group_Join_Fail(enum.Enum): ...
class Tox_Group_Mod_Event(enum.Enum): ...
class Tox_Group_Privacy_State(enum.Enum): ...
class Tox_Group_Role(enum.Enum): ...
class Tox_Group_Topic_Lock(enum.Enum): ...
class Tox_Group_Voice_State(enum.Enum): ...
class Tox_Log_Level(enum.Enum): ...
class Tox_Message_Type(enum.Enum): ...
class Tox_Options_Ptr:
    def __enter__(self) -> Self: ...
    def __exit__(self, exc_type: type[BaseException] | None, exc_value: BaseException | None, exc_traceback: TracebackType | None) -> None: ...
    def __init__(self) -> None: ...
    dht_announcements_enabled: Any
    end_port: Any
    experimental_thread_safety: Any
    hole_punching_enabled: Any
    ipv6_enabled: Any
    local_discovery_enabled: Any
    proxy_host: Any
    proxy_port: Any
    proxy_type: Any
    savedata_type: Any
    start_port: Any
    tcp_port: Any
    udp_enabled: Any
class Tox_Proxy_Type(enum.Enum): ...
class Tox_Ptr:
    def __enter__(self) -> Self: ...
    def __exit__(self, exc_type: type[BaseException] | None, exc_value: BaseException | None, exc_traceback: TracebackType | None) -> None: ...
    def __init__(self, options: Optional[Tox_Options_Ptr] = None) -> None: ...
    address: Any
    def bootstrap(self, host: str, port: int, public_key: bytes) -> bool: ...
    connection_status: Any
    def friend_add(self, address: bytes, message: bytes) -> None: ...
    def friend_add_norequest(self, public_key: bytes) -> None: ...
    def friend_delete(self, friend_number: int) -> None: ...
    group_number_groups: Any
    def handle_conference_connected(self, conference_number: Tox_Conference_Number) -> None: ...
    def handle_conference_invite(self, friend_number: Tox_Friend_Number, type_: Tox_Conference_Type, cookie: bytes) -> None: ...
    def handle_conference_message(self, conference_number: Tox_Conference_Number, peer_number: Tox_Conference_Peer_Number, type_: Tox_Message_Type, message: bytes) -> None: ...
    def handle_conference_peer_list_changed(self, conference_number: Tox_Conference_Number) -> None: ...
    def handle_conference_peer_name(self, conference_number: Tox_Conference_Number, peer_number: Tox_Conference_Peer_Number, name: bytes) -> None: ...
    def handle_conference_title(self, conference_number: Tox_Conference_Number, peer_number: Tox_Conference_Peer_Number, title: bytes) -> None: ...
    def handle_file_chunk_request(self, friend_number: Tox_Friend_Number, file_number: Tox_File_Number, position: int, length: int) -> None: ...
    def handle_file_recv(self, friend_number: Tox_Friend_Number, file_number: Tox_File_Number, kind: int, file_size: int, filename: bytes) -> None: ...
    def handle_file_recv_chunk(self, friend_number: Tox_Friend_Number, file_number: Tox_File_Number, position: int, data: bytes) -> None: ...
    def handle_file_recv_control(self, friend_number: Tox_Friend_Number, file_number: Tox_File_Number, control: Tox_File_Control) -> None: ...
    def handle_friend_connection_status(self, friend_number: Tox_Friend_Number, connection_status: Tox_Connection) -> None: ...
    def handle_friend_lossless_packet(self, friend_number: Tox_Friend_Number, data: bytes) -> None: ...
    def handle_friend_lossy_packet(self, friend_number: Tox_Friend_Number, data: bytes) -> None: ...
    def handle_friend_message(self, friend_number: Tox_Friend_Number, type_: Tox_Message_Type, message: bytes) -> None: ...
    def handle_friend_name(self, friend_number: Tox_Friend_Number, name: bytes) -> None: ...
    def handle_friend_read_receipt(self, friend_number: Tox_Friend_Number, message_id: Tox_Friend_Message_Id) -> None: ...
    def handle_friend_request(self, public_key: bytes, message: bytes) -> None: ...
    def handle_friend_status(self, friend_number: Tox_Friend_Number, status: Tox_User_Status) -> None: ...
    def handle_friend_status_message(self, friend_number: Tox_Friend_Number, message: bytes) -> None: ...
    def handle_friend_typing(self, friend_number: Tox_Friend_Number, typing: bool) -> None: ...
    def handle_group_custom_packet(self, group_number: Tox_Group_Number, peer_id: Tox_Group_Peer_Number, data: bytes) -> None: ...
    def handle_group_custom_private_packet(self, group_number: Tox_Group_Number, peer_id: Tox_Group_Peer_Number, data: bytes) -> None: ...
    def handle_group_invite(self, friend_number: Tox_Friend_Number, invite_data: bytes, group_name: bytes) -> None: ...
    def handle_group_join_fail(self, group_number: Tox_Group_Number, fail_type: Tox_Group_Join_Fail) -> None: ...
    def handle_group_message(self, group_number: Tox_Group_Number, peer_id: Tox_Group_Peer_Number, type_: Tox_Message_Type, message: bytes, message_id: Tox_Group_Message_Id) -> None: ...
    def handle_group_moderation(self, group_number: Tox_Group_Number, source_peer_id: Tox_Group_Peer_Number, target_peer_id: Tox_Group_Peer_Number, mod_type: Tox_Group_Mod_Event) -> None: ...
    def handle_group_password(self, group_number: Tox_Group_Number, password: bytes) -> None: ...
    def handle_group_peer_exit(self, group_number: Tox_Group_Number, peer_id: Tox_Group_Peer_Number, exit_type: Tox_Group_Exit_Type, name: bytes, part_message: bytes) -> None: ...
    def handle_group_peer_join(self, group_number: Tox_Group_Number, peer_id: Tox_Group_Peer_Number) -> None: ...
    def handle_group_peer_limit(self, group_number: Tox_Group_Number, peer_limit: int) -> None: ...
    def handle_group_peer_name(self, group_number: Tox_Group_Number, peer_id: Tox_Group_Peer_Number, name: bytes) -> None: ...
    def handle_group_peer_status(self, group_number: Tox_Group_Number, peer_id: Tox_Group_Peer_Number, status: Tox_User_Status) -> None: ...
    def handle_group_privacy_state(self, group_number: Tox_Group_Number, privacy_state: Tox_Group_Privacy_State) -> None: ...
    def handle_group_private_message(self, group_number: Tox_Group_Number, peer_id: Tox_Group_Peer_Number, type_: Tox_Message_Type, message: bytes) -> None: ...
    def handle_group_self_join(self, group_number: Tox_Group_Number) -> None: ...
    def handle_group_topic(self, group_number: Tox_Group_Number, peer_id: Tox_Group_Peer_Number, topic: bytes) -> None: ...
    def handle_group_topic_lock(self, group_number: Tox_Group_Number, topic_lock: Tox_Group_Topic_Lock) -> None: ...
    def handle_group_voice_state(self, group_number: Tox_Group_Number, voice_state: Tox_Group_Voice_State) -> None: ...
    def handle_self_connection_status(self, connection_status: Tox_Connection) -> None: ...
    def iterate(self) -> None: ...
    iteration_interval: Any
    name: Any
    nospam: Any
    public_key: Any
    savedata: Any
    secret_key: Any
    status: Any
    status_message: Any
class Tox_Savedata_Type(enum.Enum): ...
class Tox_User_Status(enum.Enum): ...
ADDRESS_SIZE: int
CONFERENCE_ID_SIZE: int
CONFERENCE_UID_SIZE: int
FILE_ID_LENGTH: int
HASH_LENGTH: int
MAX_CUSTOM_PACKET_SIZE: int
MAX_FILENAME_LENGTH: int
MAX_FRIEND_REQUEST_LENGTH: int
MAX_HOSTNAME_LENGTH: int
MAX_MESSAGE_LENGTH: int
MAX_NAME_LENGTH: int
MAX_STATUS_MESSAGE_LENGTH: int
NOSPAM_SIZE: int
PUBLIC_KEY_SIZE: int
SECRET_KEY_SIZE: int
TOX_CONFERENCE_TYPE_AV: Tox_Conference_Type
TOX_CONFERENCE_TYPE_TEXT: Tox_Conference_Type
TOX_CONNECTION_NONE: Tox_Connection
TOX_CONNECTION_TCP: Tox_Connection
TOX_CONNECTION_UDP: Tox_Connection
TOX_ERR_BOOTSTRAP_BAD_HOST: Tox_Err_Bootstrap
TOX_ERR_BOOTSTRAP_BAD_PORT: Tox_Err_Bootstrap
TOX_ERR_BOOTSTRAP_NULL: Tox_Err_Bootstrap
TOX_ERR_BOOTSTRAP_OK: Tox_Err_Bootstrap
TOX_ERR_CONFERENCE_BY_ID_NOT_FOUND: Tox_Err_Conference_By_Id
TOX_ERR_CONFERENCE_BY_ID_NULL: Tox_Err_Conference_By_Id
TOX_ERR_CONFERENCE_BY_ID_OK: Tox_Err_Conference_By_Id
TOX_ERR_CONFERENCE_BY_UID_NOT_FOUND: Tox_Err_Conference_By_Uid
TOX_ERR_CONFERENCE_BY_UID_NULL: Tox_Err_Conference_By_Uid
TOX_ERR_CONFERENCE_BY_UID_OK: Tox_Err_Conference_By_Uid
TOX_ERR_CONFERENCE_DELETE_CONFERENCE_NOT_FOUND: Tox_Err_Conference_Delete
TOX_ERR_CONFERENCE_DELETE_OK: Tox_Err_Conference_Delete
TOX_ERR_CONFERENCE_GET_TYPE_CONFERENCE_NOT_FOUND: Tox_Err_Conference_Get_Type
TOX_ERR_CONFERENCE_GET_TYPE_OK: Tox_Err_Conference_Get_Type
TOX_ERR_CONFERENCE_INVITE_CONFERENCE_NOT_FOUND: Tox_Err_Conference_Invite
TOX_ERR_CONFERENCE_INVITE_FAIL_SEND: Tox_Err_Conference_Invite
TOX_ERR_CONFERENCE_INVITE_NO_CONNECTION: Tox_Err_Conference_Invite
TOX_ERR_CONFERENCE_INVITE_OK: Tox_Err_Conference_Invite
TOX_ERR_CONFERENCE_JOIN_DUPLICATE: Tox_Err_Conference_Join
TOX_ERR_CONFERENCE_JOIN_FAIL_SEND: Tox_Err_Conference_Join
TOX_ERR_CONFERENCE_JOIN_FRIEND_NOT_FOUND: Tox_Err_Conference_Join
TOX_ERR_CONFERENCE_JOIN_INIT_FAIL: Tox_Err_Conference_Join
TOX_ERR_CONFERENCE_JOIN_INVALID_LENGTH: Tox_Err_Conference_Join
TOX_ERR_CONFERENCE_JOIN_OK: Tox_Err_Conference_Join
TOX_ERR_CONFERENCE_JOIN_WRONG_TYPE: Tox_Err_Conference_Join
TOX_ERR_CONFERENCE_NEW_INIT: Tox_Err_Conference_New
TOX_ERR_CONFERENCE_NEW_OK: Tox_Err_Conference_New
TOX_ERR_CONFERENCE_PEER_QUERY_CONFERENCE_NOT_FOUND: Tox_Err_Conference_Peer_Query
TOX_ERR_CONFERENCE_PEER_QUERY_NO_CONNECTION: Tox_Err_Conference_Peer_Query
TOX_ERR_CONFERENCE_PEER_QUERY_OK: Tox_Err_Conference_Peer_Query
TOX_ERR_CONFERENCE_PEER_QUERY_PEER_NOT_FOUND: Tox_Err_Conference_Peer_Query
TOX_ERR_CONFERENCE_SEND_MESSAGE_CONFERENCE_NOT_FOUND: Tox_Err_Conference_Send_Message
TOX_ERR_CONFERENCE_SEND_MESSAGE_FAIL_SEND: Tox_Err_Conference_Send_Message
TOX_ERR_CONFERENCE_SEND_MESSAGE_NO_CONNECTION: Tox_Err_Conference_Send_Message
TOX_ERR_CONFERENCE_SEND_MESSAGE_OK: Tox_Err_Conference_Send_Message
TOX_ERR_CONFERENCE_SEND_MESSAGE_TOO_LONG: Tox_Err_Conference_Send_Message
TOX_ERR_CONFERENCE_SET_MAX_OFFLINE_CONFERENCE_NOT_FOUND: Tox_Err_Conference_Set_Max_Offline
TOX_ERR_CONFERENCE_SET_MAX_OFFLINE_OK: Tox_Err_Conference_Set_Max_Offline
TOX_ERR_CONFERENCE_TITLE_CONFERENCE_NOT_FOUND: Tox_Err_Conference_Title
TOX_ERR_CONFERENCE_TITLE_FAIL_SEND: Tox_Err_Conference_Title
TOX_ERR_CONFERENCE_TITLE_INVALID_LENGTH: Tox_Err_Conference_Title
TOX_ERR_CONFERENCE_TITLE_OK: Tox_Err_Conference_Title
TOX_ERR_FILE_CONTROL_ALREADY_PAUSED: Tox_Err_File_Control
TOX_ERR_FILE_CONTROL_DENIED: Tox_Err_File_Control
TOX_ERR_FILE_CONTROL_FRIEND_NOT_CONNECTED: Tox_Err_File_Control
TOX_ERR_FILE_CONTROL_FRIEND_NOT_FOUND: Tox_Err_File_Control
TOX_ERR_FILE_CONTROL_NOT_FOUND: Tox_Err_File_Control
TOX_ERR_FILE_CONTROL_NOT_PAUSED: Tox_Err_File_Control
TOX_ERR_FILE_CONTROL_OK: Tox_Err_File_Control
TOX_ERR_FILE_CONTROL_SENDQ: Tox_Err_File_Control
TOX_ERR_FILE_GET_FRIEND_NOT_FOUND: Tox_Err_File_Get
TOX_ERR_FILE_GET_NOT_FOUND: Tox_Err_File_Get
TOX_ERR_FILE_GET_NULL: Tox_Err_File_Get
TOX_ERR_FILE_GET_OK: Tox_Err_File_Get
TOX_ERR_FILE_SEEK_DENIED: Tox_Err_File_Seek
TOX_ERR_FILE_SEEK_FRIEND_NOT_CONNECTED: Tox_Err_File_Seek
TOX_ERR_FILE_SEEK_FRIEND_NOT_FOUND: Tox_Err_File_Seek
TOX_ERR_FILE_SEEK_INVALID_POSITION: Tox_Err_File_Seek
TOX_ERR_FILE_SEEK_NOT_FOUND: Tox_Err_File_Seek
TOX_ERR_FILE_SEEK_OK: Tox_Err_File_Seek
TOX_ERR_FILE_SEEK_SENDQ: Tox_Err_File_Seek
TOX_ERR_FILE_SEND_CHUNK_FRIEND_NOT_CONNECTED: Tox_Err_File_Send
TOX_ERR_FILE_SEND_CHUNK_FRIEND_NOT_FOUND: Tox_Err_File_Send
TOX_ERR_FILE_SEND_CHUNK_INVALID_LENGTH: Tox_Err_File_Send
TOX_ERR_FILE_SEND_CHUNK_NOT_FOUND: Tox_Err_File_Send
TOX_ERR_FILE_SEND_CHUNK_NOT_TRANSFERRING: Tox_Err_File_Send
TOX_ERR_FILE_SEND_CHUNK_NULL: Tox_Err_File_Send
TOX_ERR_FILE_SEND_CHUNK_OK: Tox_Err_File_Send
TOX_ERR_FILE_SEND_CHUNK_SENDQ: Tox_Err_File_Send
TOX_ERR_FILE_SEND_CHUNK_WRONG_POSITION: Tox_Err_File_Send
TOX_ERR_FILE_SEND_FRIEND_NOT_CONNECTED: Tox_Err_File_Send
TOX_ERR_FILE_SEND_FRIEND_NOT_FOUND: Tox_Err_File_Send
TOX_ERR_FILE_SEND_NAME_TOO_LONG: Tox_Err_File_Send
TOX_ERR_FILE_SEND_NULL: Tox_Err_File_Send
TOX_ERR_FILE_SEND_OK: Tox_Err_File_Send
TOX_ERR_FILE_SEND_TOO_MANY: Tox_Err_File_Send
TOX_ERR_FRIEND_ADD_ALREADY_SENT: Tox_Err_Friend_Add
TOX_ERR_FRIEND_ADD_BAD_CHECKSUM: Tox_Err_Friend_Add
TOX_ERR_FRIEND_ADD_MALLOC: Tox_Err_Friend_Add
TOX_ERR_FRIEND_ADD_NO_MESSAGE: Tox_Err_Friend_Add
TOX_ERR_FRIEND_ADD_NULL: Tox_Err_Friend_Add
TOX_ERR_FRIEND_ADD_OK: Tox_Err_Friend_Add
TOX_ERR_FRIEND_ADD_OWN_KEY: Tox_Err_Friend_Add
TOX_ERR_FRIEND_ADD_SET_NEW_NOSPAM: Tox_Err_Friend_Add
TOX_ERR_FRIEND_ADD_TOO_LONG: Tox_Err_Friend_Add
TOX_ERR_FRIEND_BY_PUBLIC_KEY_NOT_FOUND: Tox_Err_Friend_By_Public_Key
TOX_ERR_FRIEND_BY_PUBLIC_KEY_NULL: Tox_Err_Friend_By_Public_Key
TOX_ERR_FRIEND_BY_PUBLIC_KEY_OK: Tox_Err_Friend_By_Public_Key
TOX_ERR_FRIEND_CUSTOM_PACKET_EMPTY: Tox_Err_Friend_Custom_Packet
TOX_ERR_FRIEND_CUSTOM_PACKET_FRIEND_NOT_CONNECTED: Tox_Err_Friend_Custom_Packet
TOX_ERR_FRIEND_CUSTOM_PACKET_FRIEND_NOT_FOUND: Tox_Err_Friend_Custom_Packet
TOX_ERR_FRIEND_CUSTOM_PACKET_INVALID: Tox_Err_Friend_Custom_Packet
TOX_ERR_FRIEND_CUSTOM_PACKET_NULL: Tox_Err_Friend_Custom_Packet
TOX_ERR_FRIEND_CUSTOM_PACKET_OK: Tox_Err_Friend_Custom_Packet
TOX_ERR_FRIEND_CUSTOM_PACKET_SENDQ: Tox_Err_Friend_Custom_Packet
TOX_ERR_FRIEND_CUSTOM_PACKET_TOO_LONG: Tox_Err_Friend_Custom_Packet
TOX_ERR_FRIEND_DELETE_FRIEND_NOT_FOUND: Tox_Err_Friend_Delete
TOX_ERR_FRIEND_DELETE_OK: Tox_Err_Friend_Delete
TOX_ERR_FRIEND_GET_LAST_ONLINE_FRIEND_NOT_FOUND: Tox_Err_Friend_Get_Last_Online
TOX_ERR_FRIEND_GET_LAST_ONLINE_OK: Tox_Err_Friend_Get_Last_Online
TOX_ERR_FRIEND_GET_PUBLIC_KEY_FRIEND_NOT_FOUND: Tox_Err_Friend_Get_Public_Key
TOX_ERR_FRIEND_GET_PUBLIC_KEY_OK: Tox_Err_Friend_Get_Public_Key
TOX_ERR_FRIEND_QUERY_FRIEND_NOT_FOUND: Tox_Err_Friend_Query
TOX_ERR_FRIEND_QUERY_NULL: Tox_Err_Friend_Query
TOX_ERR_FRIEND_QUERY_OK: Tox_Err_Friend_Query
TOX_ERR_FRIEND_SEND_MESSAGE_EMPTY: Tox_Err_Friend_Send_Message
TOX_ERR_FRIEND_SEND_MESSAGE_FRIEND_NOT_CONNECTED: Tox_Err_Friend_Send_Message
TOX_ERR_FRIEND_SEND_MESSAGE_FRIEND_NOT_FOUND: Tox_Err_Friend_Send_Message
TOX_ERR_FRIEND_SEND_MESSAGE_NULL: Tox_Err_Friend_Send_Message
TOX_ERR_FRIEND_SEND_MESSAGE_OK: Tox_Err_Friend_Send_Message
TOX_ERR_FRIEND_SEND_MESSAGE_SENDQ: Tox_Err_Friend_Send_Message
TOX_ERR_FRIEND_SEND_MESSAGE_TOO_LONG: Tox_Err_Friend_Send_Message
TOX_ERR_GET_PORT_NOT_BOUND: Tox_Err_Get_Port
TOX_ERR_GET_PORT_OK: Tox_Err_Get_Port
TOX_ERR_GROUP_DISCONNECT_ALREADY_DISCONNECTED: Tox_Err_Group_Disconnect
TOX_ERR_GROUP_DISCONNECT_GROUP_NOT_FOUND: Tox_Err_Group_Disconnect
TOX_ERR_GROUP_DISCONNECT_OK: Tox_Err_Group_Disconnect
TOX_ERR_GROUP_FOUNDER_SET_PASSWORD_DISCONNECTED: Tox_Err_Group_Founder_Set_Password
TOX_ERR_GROUP_FOUNDER_SET_PASSWORD_FAIL_SEND: Tox_Err_Group_Founder_Set_Password
TOX_ERR_GROUP_FOUNDER_SET_PASSWORD_GROUP_NOT_FOUND: Tox_Err_Group_Founder_Set_Password
TOX_ERR_GROUP_FOUNDER_SET_PASSWORD_MALLOC: Tox_Err_Group_Founder_Set_Password
TOX_ERR_GROUP_FOUNDER_SET_PASSWORD_OK: Tox_Err_Group_Founder_Set_Password
TOX_ERR_GROUP_FOUNDER_SET_PASSWORD_PERMISSIONS: Tox_Err_Group_Founder_Set_Password
TOX_ERR_GROUP_FOUNDER_SET_PASSWORD_TOO_LONG: Tox_Err_Group_Founder_Set_Password
TOX_ERR_GROUP_FOUNDER_SET_PEER_LIMIT_DISCONNECTED: Tox_Err_Group_Founder_Set_Peer_Limit
TOX_ERR_GROUP_FOUNDER_SET_PEER_LIMIT_FAIL_SEND: Tox_Err_Group_Founder_Set_Peer_Limit
TOX_ERR_GROUP_FOUNDER_SET_PEER_LIMIT_FAIL_SET: Tox_Err_Group_Founder_Set_Peer_Limit
TOX_ERR_GROUP_FOUNDER_SET_PEER_LIMIT_GROUP_NOT_FOUND: Tox_Err_Group_Founder_Set_Peer_Limit
TOX_ERR_GROUP_FOUNDER_SET_PEER_LIMIT_OK: Tox_Err_Group_Founder_Set_Peer_Limit
TOX_ERR_GROUP_FOUNDER_SET_PEER_LIMIT_PERMISSIONS: Tox_Err_Group_Founder_Set_Peer_Limit
TOX_ERR_GROUP_FOUNDER_SET_PRIVACY_STATE_DISCONNECTED: Tox_Err_Group_Founder_Set_Privacy_State
TOX_ERR_GROUP_FOUNDER_SET_PRIVACY_STATE_FAIL_SEND: Tox_Err_Group_Founder_Set_Privacy_State
TOX_ERR_GROUP_FOUNDER_SET_PRIVACY_STATE_FAIL_SET: Tox_Err_Group_Founder_Set_Privacy_State
TOX_ERR_GROUP_FOUNDER_SET_PRIVACY_STATE_GROUP_NOT_FOUND: Tox_Err_Group_Founder_Set_Privacy_State
TOX_ERR_GROUP_FOUNDER_SET_PRIVACY_STATE_OK: Tox_Err_Group_Founder_Set_Privacy_State
TOX_ERR_GROUP_FOUNDER_SET_PRIVACY_STATE_PERMISSIONS: Tox_Err_Group_Founder_Set_Privacy_State
TOX_ERR_GROUP_FOUNDER_SET_TOPIC_LOCK_DISCONNECTED: Tox_Err_Group_Founder_Set_Topic_Lock
TOX_ERR_GROUP_FOUNDER_SET_TOPIC_LOCK_FAIL_SEND: Tox_Err_Group_Founder_Set_Topic_Lock
TOX_ERR_GROUP_FOUNDER_SET_TOPIC_LOCK_FAIL_SET: Tox_Err_Group_Founder_Set_Topic_Lock
TOX_ERR_GROUP_FOUNDER_SET_TOPIC_LOCK_GROUP_NOT_FOUND: Tox_Err_Group_Founder_Set_Topic_Lock
TOX_ERR_GROUP_FOUNDER_SET_TOPIC_LOCK_INVALID: Tox_Err_Group_Founder_Set_Topic_Lock
TOX_ERR_GROUP_FOUNDER_SET_TOPIC_LOCK_OK: Tox_Err_Group_Founder_Set_Topic_Lock
TOX_ERR_GROUP_FOUNDER_SET_TOPIC_LOCK_PERMISSIONS: Tox_Err_Group_Founder_Set_Topic_Lock
TOX_ERR_GROUP_FOUNDER_SET_VOICE_STATE_DISCONNECTED: Tox_Err_Group_Founder_Set_Voice_State
TOX_ERR_GROUP_FOUNDER_SET_VOICE_STATE_FAIL_SEND: Tox_Err_Group_Founder_Set_Voice_State
TOX_ERR_GROUP_FOUNDER_SET_VOICE_STATE_FAIL_SET: Tox_Err_Group_Founder_Set_Voice_State
TOX_ERR_GROUP_FOUNDER_SET_VOICE_STATE_GROUP_NOT_FOUND: Tox_Err_Group_Founder_Set_Voice_State
TOX_ERR_GROUP_FOUNDER_SET_VOICE_STATE_OK: Tox_Err_Group_Founder_Set_Voice_State
TOX_ERR_GROUP_FOUNDER_SET_VOICE_STATE_PERMISSIONS: Tox_Err_Group_Founder_Set_Voice_State
TOX_ERR_GROUP_INVITE_ACCEPT_BAD_INVITE: Tox_Err_Group_Invite_Accept
TOX_ERR_GROUP_INVITE_ACCEPT_CORE: Tox_Err_Group_Invite_Accept
TOX_ERR_GROUP_INVITE_ACCEPT_EMPTY: Tox_Err_Group_Invite_Accept
TOX_ERR_GROUP_INVITE_ACCEPT_FAIL_SEND: Tox_Err_Group_Invite_Accept
TOX_ERR_GROUP_INVITE_ACCEPT_INIT_FAILED: Tox_Err_Group_Invite_Accept
TOX_ERR_GROUP_INVITE_ACCEPT_OK: Tox_Err_Group_Invite_Accept
TOX_ERR_GROUP_INVITE_ACCEPT_PASSWORD: Tox_Err_Group_Invite_Accept
TOX_ERR_GROUP_INVITE_ACCEPT_TOO_LONG: Tox_Err_Group_Invite_Accept
TOX_ERR_GROUP_INVITE_FRIEND_DISCONNECTED: Tox_Err_Group_Invite_Friend
TOX_ERR_GROUP_INVITE_FRIEND_FAIL_SEND: Tox_Err_Group_Invite_Friend
TOX_ERR_GROUP_INVITE_FRIEND_FRIEND_NOT_FOUND: Tox_Err_Group_Invite_Friend
TOX_ERR_GROUP_INVITE_FRIEND_GROUP_NOT_FOUND: Tox_Err_Group_Invite_Friend
TOX_ERR_GROUP_INVITE_FRIEND_INVITE_FAIL: Tox_Err_Group_Invite_Friend
TOX_ERR_GROUP_INVITE_FRIEND_OK: Tox_Err_Group_Invite_Friend
TOX_ERR_GROUP_IS_CONNECTED_GROUP_NOT_FOUND: Tox_Err_Group_Is_Connected
TOX_ERR_GROUP_IS_CONNECTED_OK: Tox_Err_Group_Is_Connected
TOX_ERR_GROUP_JOIN_BAD_CHAT_ID: Tox_Err_Group_Join
TOX_ERR_GROUP_JOIN_CORE: Tox_Err_Group_Join
TOX_ERR_GROUP_JOIN_EMPTY: Tox_Err_Group_Join
TOX_ERR_GROUP_JOIN_INIT: Tox_Err_Group_Join
TOX_ERR_GROUP_JOIN_OK: Tox_Err_Group_Join
TOX_ERR_GROUP_JOIN_PASSWORD: Tox_Err_Group_Join
TOX_ERR_GROUP_JOIN_TOO_LONG: Tox_Err_Group_Join
TOX_ERR_GROUP_LEAVE_FAIL_SEND: Tox_Err_Group_Leave
TOX_ERR_GROUP_LEAVE_GROUP_NOT_FOUND: Tox_Err_Group_Leave
TOX_ERR_GROUP_LEAVE_OK: Tox_Err_Group_Leave
TOX_ERR_GROUP_LEAVE_TOO_LONG: Tox_Err_Group_Leave
TOX_ERR_GROUP_MOD_KICK_PEER_FAIL_ACTION: Tox_Err_Group_Mod_Kick_Peer
TOX_ERR_GROUP_MOD_KICK_PEER_FAIL_SEND: Tox_Err_Group_Mod_Kick_Peer
TOX_ERR_GROUP_MOD_KICK_PEER_GROUP_NOT_FOUND: Tox_Err_Group_Mod_Kick_Peer
TOX_ERR_GROUP_MOD_KICK_PEER_OK: Tox_Err_Group_Mod_Kick_Peer
TOX_ERR_GROUP_MOD_KICK_PEER_PEER_NOT_FOUND: Tox_Err_Group_Mod_Kick_Peer
TOX_ERR_GROUP_MOD_KICK_PEER_PERMISSIONS: Tox_Err_Group_Mod_Kick_Peer
TOX_ERR_GROUP_MOD_KICK_PEER_SELF: Tox_Err_Group_Mod_Kick_Peer
TOX_ERR_GROUP_MOD_SET_ROLE_ASSIGNMENT: Tox_Err_Group_Mod_Set_Role
TOX_ERR_GROUP_MOD_SET_ROLE_FAIL_ACTION: Tox_Err_Group_Mod_Set_Role
TOX_ERR_GROUP_MOD_SET_ROLE_GROUP_NOT_FOUND: Tox_Err_Group_Mod_Set_Role
TOX_ERR_GROUP_MOD_SET_ROLE_OK: Tox_Err_Group_Mod_Set_Role
TOX_ERR_GROUP_MOD_SET_ROLE_PEER_NOT_FOUND: Tox_Err_Group_Mod_Set_Role
TOX_ERR_GROUP_MOD_SET_ROLE_PERMISSIONS: Tox_Err_Group_Mod_Set_Role
TOX_ERR_GROUP_MOD_SET_ROLE_SELF: Tox_Err_Group_Mod_Set_Role
TOX_ERR_GROUP_NEW_ANNOUNCE: Tox_Err_Group_New
TOX_ERR_GROUP_NEW_EMPTY: Tox_Err_Group_New
TOX_ERR_GROUP_NEW_INIT: Tox_Err_Group_New
TOX_ERR_GROUP_NEW_OK: Tox_Err_Group_New
TOX_ERR_GROUP_NEW_STATE: Tox_Err_Group_New
TOX_ERR_GROUP_NEW_TOO_LONG: Tox_Err_Group_New
TOX_ERR_GROUP_PEER_QUERY_GROUP_NOT_FOUND: Tox_Err_Group_Peer_Query
TOX_ERR_GROUP_PEER_QUERY_OK: Tox_Err_Group_Peer_Query
TOX_ERR_GROUP_PEER_QUERY_PEER_NOT_FOUND: Tox_Err_Group_Peer_Query
TOX_ERR_GROUP_RECONNECT_CORE: Tox_Err_Group_Reconnect
TOX_ERR_GROUP_RECONNECT_GROUP_NOT_FOUND: Tox_Err_Group_Reconnect
TOX_ERR_GROUP_RECONNECT_OK: Tox_Err_Group_Reconnect
TOX_ERR_GROUP_SELF_NAME_SET_FAIL_SEND: Tox_Err_Group_Self_Name_Set
TOX_ERR_GROUP_SELF_NAME_SET_GROUP_NOT_FOUND: Tox_Err_Group_Self_Name_Set
TOX_ERR_GROUP_SELF_NAME_SET_INVALID: Tox_Err_Group_Self_Name_Set
TOX_ERR_GROUP_SELF_NAME_SET_OK: Tox_Err_Group_Self_Name_Set
TOX_ERR_GROUP_SELF_NAME_SET_TOO_LONG: Tox_Err_Group_Self_Name_Set
TOX_ERR_GROUP_SELF_QUERY_GROUP_NOT_FOUND: Tox_Err_Group_Self_Query
TOX_ERR_GROUP_SELF_QUERY_OK: Tox_Err_Group_Self_Query
TOX_ERR_GROUP_SELF_STATUS_SET_FAIL_SEND: Tox_Err_Group_Self_Status_Set
TOX_ERR_GROUP_SELF_STATUS_SET_GROUP_NOT_FOUND: Tox_Err_Group_Self_Status_Set
TOX_ERR_GROUP_SELF_STATUS_SET_OK: Tox_Err_Group_Self_Status_Set
TOX_ERR_GROUP_SEND_CUSTOM_PACKET_DISCONNECTED: Tox_Err_Group_Send_Custom_Packet
TOX_ERR_GROUP_SEND_CUSTOM_PACKET_EMPTY: Tox_Err_Group_Send_Custom_Packet
TOX_ERR_GROUP_SEND_CUSTOM_PACKET_GROUP_NOT_FOUND: Tox_Err_Group_Send_Custom_Packet
TOX_ERR_GROUP_SEND_CUSTOM_PACKET_OK: Tox_Err_Group_Send_Custom_Packet
TOX_ERR_GROUP_SEND_CUSTOM_PACKET_PERMISSIONS: Tox_Err_Group_Send_Custom_Packet
TOX_ERR_GROUP_SEND_CUSTOM_PACKET_TOO_LONG: Tox_Err_Group_Send_Custom_Packet
TOX_ERR_GROUP_SEND_CUSTOM_PRIVATE_PACKET_DISCONNECTED: Tox_Err_Group_Send_Custom_Private_Packet
TOX_ERR_GROUP_SEND_CUSTOM_PRIVATE_PACKET_EMPTY: Tox_Err_Group_Send_Custom_Private_Packet
TOX_ERR_GROUP_SEND_CUSTOM_PRIVATE_PACKET_FAIL_SEND: Tox_Err_Group_Send_Custom_Private_Packet
TOX_ERR_GROUP_SEND_CUSTOM_PRIVATE_PACKET_GROUP_NOT_FOUND: Tox_Err_Group_Send_Custom_Private_Packet
TOX_ERR_GROUP_SEND_CUSTOM_PRIVATE_PACKET_OK: Tox_Err_Group_Send_Custom_Private_Packet
TOX_ERR_GROUP_SEND_CUSTOM_PRIVATE_PACKET_PEER_NOT_FOUND: Tox_Err_Group_Send_Custom_Private_Packet
TOX_ERR_GROUP_SEND_CUSTOM_PRIVATE_PACKET_PERMISSIONS: Tox_Err_Group_Send_Custom_Private_Packet
TOX_ERR_GROUP_SEND_CUSTOM_PRIVATE_PACKET_TOO_LONG: Tox_Err_Group_Send_Custom_Private_Packet
TOX_ERR_GROUP_SEND_MESSAGE_BAD_TYPE: Tox_Err_Group_Send_Message
TOX_ERR_GROUP_SEND_MESSAGE_DISCONNECTED: Tox_Err_Group_Send_Message
TOX_ERR_GROUP_SEND_MESSAGE_EMPTY: Tox_Err_Group_Send_Message
TOX_ERR_GROUP_SEND_MESSAGE_FAIL_SEND: Tox_Err_Group_Send_Message
TOX_ERR_GROUP_SEND_MESSAGE_GROUP_NOT_FOUND: Tox_Err_Group_Send_Message
TOX_ERR_GROUP_SEND_MESSAGE_OK: Tox_Err_Group_Send_Message
TOX_ERR_GROUP_SEND_MESSAGE_PERMISSIONS: Tox_Err_Group_Send_Message
TOX_ERR_GROUP_SEND_MESSAGE_TOO_LONG: Tox_Err_Group_Send_Message
TOX_ERR_GROUP_SEND_PRIVATE_MESSAGE_BAD_TYPE: Tox_Err_Group_Send_Private_Message
TOX_ERR_GROUP_SEND_PRIVATE_MESSAGE_DISCONNECTED: Tox_Err_Group_Send_Private_Message
TOX_ERR_GROUP_SEND_PRIVATE_MESSAGE_EMPTY: Tox_Err_Group_Send_Private_Message
TOX_ERR_GROUP_SEND_PRIVATE_MESSAGE_FAIL_SEND: Tox_Err_Group_Send_Private_Message
TOX_ERR_GROUP_SEND_PRIVATE_MESSAGE_GROUP_NOT_FOUND: Tox_Err_Group_Send_Private_Message
TOX_ERR_GROUP_SEND_PRIVATE_MESSAGE_OK: Tox_Err_Group_Send_Private_Message
TOX_ERR_GROUP_SEND_PRIVATE_MESSAGE_PEER_NOT_FOUND: Tox_Err_Group_Send_Private_Message
TOX_ERR_GROUP_SEND_PRIVATE_MESSAGE_PERMISSIONS: Tox_Err_Group_Send_Private_Message
TOX_ERR_GROUP_SEND_PRIVATE_MESSAGE_TOO_LONG: Tox_Err_Group_Send_Private_Message
TOX_ERR_GROUP_SET_IGNORE_GROUP_NOT_FOUND: Tox_Err_Group_Set_Ignore
TOX_ERR_GROUP_SET_IGNORE_OK: Tox_Err_Group_Set_Ignore
TOX_ERR_GROUP_SET_IGNORE_PEER_NOT_FOUND: Tox_Err_Group_Set_Ignore
TOX_ERR_GROUP_SET_IGNORE_SELF: Tox_Err_Group_Set_Ignore
TOX_ERR_GROUP_STATE_QUERIES_GROUP_NOT_FOUND: Tox_Err_Group_State_Queries
TOX_ERR_GROUP_STATE_QUERIES_OK: Tox_Err_Group_State_Queries
TOX_ERR_GROUP_TOPIC_SET_DISCONNECTED: Tox_Err_Group_Topic_Set
TOX_ERR_GROUP_TOPIC_SET_FAIL_CREATE: Tox_Err_Group_Topic_Set
TOX_ERR_GROUP_TOPIC_SET_FAIL_SEND: Tox_Err_Group_Topic_Set
TOX_ERR_GROUP_TOPIC_SET_GROUP_NOT_FOUND: Tox_Err_Group_Topic_Set
TOX_ERR_GROUP_TOPIC_SET_OK: Tox_Err_Group_Topic_Set
TOX_ERR_GROUP_TOPIC_SET_PERMISSIONS: Tox_Err_Group_Topic_Set
TOX_ERR_GROUP_TOPIC_SET_TOO_LONG: Tox_Err_Group_Topic_Set
TOX_ERR_NEW_LOAD_BAD_FORMAT: Tox_Err_New
TOX_ERR_NEW_LOAD_ENCRYPTED: Tox_Err_New
TOX_ERR_NEW_MALLOC: Tox_Err_New
TOX_ERR_NEW_NULL: Tox_Err_New
TOX_ERR_NEW_OK: Tox_Err_New
TOX_ERR_NEW_PORT_ALLOC: Tox_Err_New
TOX_ERR_NEW_PROXY_BAD_HOST: Tox_Err_New
TOX_ERR_NEW_PROXY_BAD_PORT: Tox_Err_New
TOX_ERR_NEW_PROXY_BAD_TYPE: Tox_Err_New
TOX_ERR_NEW_PROXY_NOT_FOUND: Tox_Err_New
TOX_ERR_OPTIONS_NEW_MALLOC: Tox_Err_Options_New
TOX_ERR_OPTIONS_NEW_OK: Tox_Err_Options_New
TOX_ERR_SET_INFO_NULL: Tox_Err_Set_Info
TOX_ERR_SET_INFO_OK: Tox_Err_Set_Info
TOX_ERR_SET_INFO_TOO_LONG: Tox_Err_Set_Info
TOX_ERR_SET_TYPING_FRIEND_NOT_FOUND: Tox_Err_Set_Typing
TOX_ERR_SET_TYPING_OK: Tox_Err_Set_Typing
TOX_FILE_CONTROL_CANCEL: Tox_File_Control
TOX_FILE_CONTROL_PAUSE: Tox_File_Control
TOX_FILE_CONTROL_RESUME: Tox_File_Control
TOX_FILE_KIND_AVATAR: Tox_File_Kind
TOX_FILE_KIND_DATA: Tox_File_Kind
TOX_GROUP_EXIT_TYPE_DISCONNECTED: Tox_Group_Exit_Type
TOX_GROUP_EXIT_TYPE_KICK: Tox_Group_Exit_Type
TOX_GROUP_EXIT_TYPE_QUIT: Tox_Group_Exit_Type
TOX_GROUP_EXIT_TYPE_SELF_DISCONNECTED: Tox_Group_Exit_Type
TOX_GROUP_EXIT_TYPE_SYNC_ERROR: Tox_Group_Exit_Type
TOX_GROUP_EXIT_TYPE_TIMEOUT: Tox_Group_Exit_Type
TOX_GROUP_JOIN_FAIL_INVALID_PASSWORD: Tox_Group_Join_Fail
TOX_GROUP_JOIN_FAIL_PEER_LIMIT: Tox_Group_Join_Fail
TOX_GROUP_JOIN_FAIL_UNKNOWN: Tox_Group_Join_Fail
TOX_GROUP_MOD_EVENT_KICK: Tox_Group_Mod_Event
TOX_GROUP_MOD_EVENT_MODERATOR: Tox_Group_Mod_Event
TOX_GROUP_MOD_EVENT_OBSERVER: Tox_Group_Mod_Event
TOX_GROUP_MOD_EVENT_USER: Tox_Group_Mod_Event
TOX_GROUP_PRIVACY_STATE_PRIVATE: Tox_Group_Privacy_State
TOX_GROUP_PRIVACY_STATE_PUBLIC: Tox_Group_Privacy_State
TOX_GROUP_ROLE_FOUNDER: Tox_Group_Role
TOX_GROUP_ROLE_MODERATOR: Tox_Group_Role
TOX_GROUP_ROLE_OBSERVER: Tox_Group_Role
TOX_GROUP_ROLE_USER: Tox_Group_Role
TOX_GROUP_TOPIC_LOCK_DISABLED: Tox_Group_Topic_Lock
TOX_GROUP_TOPIC_LOCK_ENABLED: Tox_Group_Topic_Lock
TOX_GROUP_VOICE_STATE_ALL: Tox_Group_Voice_State
TOX_GROUP_VOICE_STATE_FOUNDER: Tox_Group_Voice_State
TOX_GROUP_VOICE_STATE_MODERATOR: Tox_Group_Voice_State
TOX_LOG_LEVEL_DEBUG: Tox_Log_Level
TOX_LOG_LEVEL_ERROR: Tox_Log_Level
TOX_LOG_LEVEL_INFO: Tox_Log_Level
TOX_LOG_LEVEL_TRACE: Tox_Log_Level
TOX_LOG_LEVEL_WARNING: Tox_Log_Level
TOX_MESSAGE_TYPE_ACTION: Tox_Message_Type
TOX_MESSAGE_TYPE_NORMAL: Tox_Message_Type
TOX_PROXY_TYPE_HTTP: Tox_Proxy_Type
TOX_PROXY_TYPE_NONE: Tox_Proxy_Type
TOX_PROXY_TYPE_SOCKS5: Tox_Proxy_Type
TOX_SAVEDATA_TYPE_NONE: Tox_Savedata_Type
TOX_SAVEDATA_TYPE_SECRET_KEY: Tox_Savedata_Type
TOX_SAVEDATA_TYPE_TOX_SAVE: Tox_Savedata_Type
TOX_USER_STATUS_AWAY: Tox_User_Status
TOX_USER_STATUS_BUSY: Tox_User_Status
TOX_USER_STATUS_NONE: Tox_User_Status
VERSION: str

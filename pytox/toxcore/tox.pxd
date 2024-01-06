# cython: language_level=3
from libcpp cimport bool
from libc.stdint cimport uint8_t, uint16_t, uint32_t, uint64_t
from libc.stdlib cimport malloc, free

cdef extern from "tox/tox.h":
    cpdef enum Tox_Err_Options_New:
        TOX_ERR_OPTIONS_NEW_OK
        TOX_ERR_OPTIONS_NEW_MALLOC
    cpdef enum Tox_User_Status:
        TOX_USER_STATUS_NONE
        TOX_USER_STATUS_AWAY
        TOX_USER_STATUS_BUSY
    cpdef enum Tox_Message_Type:
        TOX_MESSAGE_TYPE_NORMAL
        TOX_MESSAGE_TYPE_ACTION
    cpdef enum Tox_Proxy_Type:
        TOX_PROXY_TYPE_NONE
        TOX_PROXY_TYPE_HTTP
        TOX_PROXY_TYPE_SOCKS5
    cpdef enum Tox_Savedata_Type:
        TOX_SAVEDATA_TYPE_NONE
        TOX_SAVEDATA_TYPE_TOX_SAVE
        TOX_SAVEDATA_TYPE_SECRET_KEY
    cpdef enum Tox_Log_Level:
        TOX_LOG_LEVEL_TRACE
        TOX_LOG_LEVEL_DEBUG
        TOX_LOG_LEVEL_INFO
        TOX_LOG_LEVEL_WARNING
        TOX_LOG_LEVEL_ERROR
    cpdef enum Tox_Err_New:
        TOX_ERR_NEW_OK
        TOX_ERR_NEW_NULL
        TOX_ERR_NEW_MALLOC
        TOX_ERR_NEW_PORT_ALLOC
        TOX_ERR_NEW_PROXY_BAD_TYPE
        TOX_ERR_NEW_PROXY_BAD_HOST
        TOX_ERR_NEW_PROXY_BAD_PORT
        TOX_ERR_NEW_PROXY_NOT_FOUND
        TOX_ERR_NEW_LOAD_ENCRYPTED
        TOX_ERR_NEW_LOAD_BAD_FORMAT
    cpdef enum Tox_Err_Bootstrap:
        TOX_ERR_BOOTSTRAP_OK
        TOX_ERR_BOOTSTRAP_NULL
        TOX_ERR_BOOTSTRAP_BAD_HOST
        TOX_ERR_BOOTSTRAP_BAD_PORT
    cpdef enum Tox_Connection:
        TOX_CONNECTION_NONE
        TOX_CONNECTION_TCP
        TOX_CONNECTION_UDP
    cpdef enum Tox_Err_Set_Info:
        TOX_ERR_SET_INFO_OK
        TOX_ERR_SET_INFO_NULL
        TOX_ERR_SET_INFO_TOO_LONG
    cpdef enum Tox_Err_Set_Typing:
        TOX_ERR_SET_TYPING_OK
        TOX_ERR_SET_TYPING_FRIEND_NOT_FOUND
    cpdef enum Tox_Err_Get_Port:
        TOX_ERR_GET_PORT_OK
        TOX_ERR_GET_PORT_NOT_BOUND
    cpdef enum Tox_Err_Friend_Add:
        TOX_ERR_FRIEND_ADD_OK
        TOX_ERR_FRIEND_ADD_NULL
        TOX_ERR_FRIEND_ADD_TOO_LONG
        TOX_ERR_FRIEND_ADD_NO_MESSAGE
        TOX_ERR_FRIEND_ADD_OWN_KEY
        TOX_ERR_FRIEND_ADD_ALREADY_SENT
        TOX_ERR_FRIEND_ADD_BAD_CHECKSUM
        TOX_ERR_FRIEND_ADD_SET_NEW_NOSPAM
        TOX_ERR_FRIEND_ADD_MALLOC
    cpdef enum Tox_Err_Friend_Delete:
        TOX_ERR_FRIEND_DELETE_OK
        TOX_ERR_FRIEND_DELETE_FRIEND_NOT_FOUND
    cpdef enum Tox_Err_Friend_By_Public_Key:
        TOX_ERR_FRIEND_BY_PUBLIC_KEY_OK
        TOX_ERR_FRIEND_BY_PUBLIC_KEY_NULL
        TOX_ERR_FRIEND_BY_PUBLIC_KEY_NOT_FOUND
    cpdef enum Tox_Err_Friend_Get_Public_Key:
        TOX_ERR_FRIEND_GET_PUBLIC_KEY_OK
        TOX_ERR_FRIEND_GET_PUBLIC_KEY_FRIEND_NOT_FOUND
    cpdef enum Tox_Err_Friend_Get_Last_Online:
        TOX_ERR_FRIEND_GET_LAST_ONLINE_OK
        TOX_ERR_FRIEND_GET_LAST_ONLINE_FRIEND_NOT_FOUND
    cpdef enum Tox_Err_Friend_Query:
        TOX_ERR_FRIEND_QUERY_OK
        TOX_ERR_FRIEND_QUERY_NULL
        TOX_ERR_FRIEND_QUERY_FRIEND_NOT_FOUND
    cpdef enum Tox_Err_Friend_Send_Message:
        TOX_ERR_FRIEND_SEND_MESSAGE_OK
        TOX_ERR_FRIEND_SEND_MESSAGE_NULL
        TOX_ERR_FRIEND_SEND_MESSAGE_FRIEND_NOT_FOUND
        TOX_ERR_FRIEND_SEND_MESSAGE_FRIEND_NOT_CONNECTED
        TOX_ERR_FRIEND_SEND_MESSAGE_SENDQ
        TOX_ERR_FRIEND_SEND_MESSAGE_TOO_LONG
        TOX_ERR_FRIEND_SEND_MESSAGE_EMPTY
    cpdef enum Tox_Err_Friend_Custom_Packet:
        TOX_ERR_FRIEND_CUSTOM_PACKET_OK
        TOX_ERR_FRIEND_CUSTOM_PACKET_NULL
        TOX_ERR_FRIEND_CUSTOM_PACKET_FRIEND_NOT_FOUND
        TOX_ERR_FRIEND_CUSTOM_PACKET_FRIEND_NOT_CONNECTED
        TOX_ERR_FRIEND_CUSTOM_PACKET_INVALID
        TOX_ERR_FRIEND_CUSTOM_PACKET_EMPTY
        TOX_ERR_FRIEND_CUSTOM_PACKET_TOO_LONG
        TOX_ERR_FRIEND_CUSTOM_PACKET_SENDQ
    cpdef enum Tox_File_Kind:
        TOX_FILE_KIND_DATA
        TOX_FILE_KIND_AVATAR
    cpdef enum Tox_File_Control:
        TOX_FILE_CONTROL_RESUME
        TOX_FILE_CONTROL_PAUSE
        TOX_FILE_CONTROL_CANCEL
    cpdef enum Tox_Err_File_Control:
        TOX_ERR_FILE_CONTROL_OK
        TOX_ERR_FILE_CONTROL_FRIEND_NOT_FOUND
        TOX_ERR_FILE_CONTROL_FRIEND_NOT_CONNECTED
        TOX_ERR_FILE_CONTROL_NOT_FOUND
        TOX_ERR_FILE_CONTROL_NOT_PAUSED
        TOX_ERR_FILE_CONTROL_DENIED
        TOX_ERR_FILE_CONTROL_ALREADY_PAUSED
        TOX_ERR_FILE_CONTROL_SENDQ
    cpdef enum Tox_Err_File_Seek:
        TOX_ERR_FILE_SEEK_OK
        TOX_ERR_FILE_SEEK_FRIEND_NOT_FOUND
        TOX_ERR_FILE_SEEK_FRIEND_NOT_CONNECTED
        TOX_ERR_FILE_SEEK_NOT_FOUND
        TOX_ERR_FILE_SEEK_DENIED
        TOX_ERR_FILE_SEEK_INVALID_POSITION
        TOX_ERR_FILE_SEEK_SENDQ
    cpdef enum Tox_Err_File_Get:
        TOX_ERR_FILE_GET_OK
        TOX_ERR_FILE_GET_NULL
        TOX_ERR_FILE_GET_FRIEND_NOT_FOUND
        TOX_ERR_FILE_GET_NOT_FOUND
    cpdef enum Tox_Err_File_Send:
        TOX_ERR_FILE_SEND_OK
        TOX_ERR_FILE_SEND_NULL
        TOX_ERR_FILE_SEND_FRIEND_NOT_FOUND
        TOX_ERR_FILE_SEND_FRIEND_NOT_CONNECTED
        TOX_ERR_FILE_SEND_NAME_TOO_LONG
        TOX_ERR_FILE_SEND_TOO_MANY
    cpdef enum Tox_Err_File_Send_Chunk:
        TOX_ERR_FILE_SEND_CHUNK_OK
        TOX_ERR_FILE_SEND_CHUNK_NULL
        TOX_ERR_FILE_SEND_CHUNK_FRIEND_NOT_FOUND
        TOX_ERR_FILE_SEND_CHUNK_FRIEND_NOT_CONNECTED
        TOX_ERR_FILE_SEND_CHUNK_NOT_FOUND
        TOX_ERR_FILE_SEND_CHUNK_NOT_TRANSFERRING
        TOX_ERR_FILE_SEND_CHUNK_INVALID_LENGTH
        TOX_ERR_FILE_SEND_CHUNK_SENDQ
        TOX_ERR_FILE_SEND_CHUNK_WRONG_POSITION
    cpdef enum Tox_Err_Conference_Peer_Query:
        TOX_ERR_CONFERENCE_PEER_QUERY_OK
        TOX_ERR_CONFERENCE_PEER_QUERY_CONFERENCE_NOT_FOUND
        TOX_ERR_CONFERENCE_PEER_QUERY_PEER_NOT_FOUND
        TOX_ERR_CONFERENCE_PEER_QUERY_NO_CONNECTION
    cpdef enum Tox_Conference_Type:
        TOX_CONFERENCE_TYPE_TEXT
        TOX_CONFERENCE_TYPE_AV
    cpdef enum Tox_Err_Conference_New:
        TOX_ERR_CONFERENCE_NEW_OK
        TOX_ERR_CONFERENCE_NEW_INIT
    cpdef enum Tox_Err_Conference_Delete:
        TOX_ERR_CONFERENCE_DELETE_OK
        TOX_ERR_CONFERENCE_DELETE_CONFERENCE_NOT_FOUND
    cpdef enum Tox_Err_Conference_Set_Max_Offline:
        TOX_ERR_CONFERENCE_SET_MAX_OFFLINE_OK
        TOX_ERR_CONFERENCE_SET_MAX_OFFLINE_CONFERENCE_NOT_FOUND
    cpdef enum Tox_Err_Conference_Invite:
        TOX_ERR_CONFERENCE_INVITE_OK
        TOX_ERR_CONFERENCE_INVITE_CONFERENCE_NOT_FOUND
        TOX_ERR_CONFERENCE_INVITE_FAIL_SEND
        TOX_ERR_CONFERENCE_INVITE_NO_CONNECTION
    cpdef enum Tox_Err_Conference_Join:
        TOX_ERR_CONFERENCE_JOIN_OK
        TOX_ERR_CONFERENCE_JOIN_INVALID_LENGTH
        TOX_ERR_CONFERENCE_JOIN_WRONG_TYPE
        TOX_ERR_CONFERENCE_JOIN_FRIEND_NOT_FOUND
        TOX_ERR_CONFERENCE_JOIN_DUPLICATE
        TOX_ERR_CONFERENCE_JOIN_INIT_FAIL
        TOX_ERR_CONFERENCE_JOIN_FAIL_SEND
    cpdef enum Tox_Err_Conference_Send_Message:
        TOX_ERR_CONFERENCE_SEND_MESSAGE_OK
        TOX_ERR_CONFERENCE_SEND_MESSAGE_CONFERENCE_NOT_FOUND
        TOX_ERR_CONFERENCE_SEND_MESSAGE_TOO_LONG
        TOX_ERR_CONFERENCE_SEND_MESSAGE_NO_CONNECTION
        TOX_ERR_CONFERENCE_SEND_MESSAGE_FAIL_SEND
    cpdef enum Tox_Err_Conference_Title:
        TOX_ERR_CONFERENCE_TITLE_OK
        TOX_ERR_CONFERENCE_TITLE_CONFERENCE_NOT_FOUND
        TOX_ERR_CONFERENCE_TITLE_INVALID_LENGTH
        TOX_ERR_CONFERENCE_TITLE_FAIL_SEND
    cpdef enum Tox_Err_Conference_Get_Type:
        TOX_ERR_CONFERENCE_GET_TYPE_OK
        TOX_ERR_CONFERENCE_GET_TYPE_CONFERENCE_NOT_FOUND
    cpdef enum Tox_Err_Conference_By_Id:
        TOX_ERR_CONFERENCE_BY_ID_OK
        TOX_ERR_CONFERENCE_BY_ID_NULL
        TOX_ERR_CONFERENCE_BY_ID_NOT_FOUND
    cpdef enum Tox_Err_Conference_By_Uid:
        TOX_ERR_CONFERENCE_BY_UID_OK
        TOX_ERR_CONFERENCE_BY_UID_NULL
        TOX_ERR_CONFERENCE_BY_UID_NOT_FOUND
    cpdef enum Tox_Err_Group_Self_Query:
        TOX_ERR_GROUP_SELF_QUERY_OK
        TOX_ERR_GROUP_SELF_QUERY_GROUP_NOT_FOUND
    cpdef enum Tox_Err_Group_Self_Name_Set:
        TOX_ERR_GROUP_SELF_NAME_SET_OK
        TOX_ERR_GROUP_SELF_NAME_SET_GROUP_NOT_FOUND
        TOX_ERR_GROUP_SELF_NAME_SET_TOO_LONG
        TOX_ERR_GROUP_SELF_NAME_SET_INVALID
        TOX_ERR_GROUP_SELF_NAME_SET_FAIL_SEND
    cpdef enum Tox_Err_Group_Self_Status_Set:
        TOX_ERR_GROUP_SELF_STATUS_SET_OK
        TOX_ERR_GROUP_SELF_STATUS_SET_GROUP_NOT_FOUND
        TOX_ERR_GROUP_SELF_STATUS_SET_FAIL_SEND
    cpdef enum Tox_Err_Group_Peer_Query:
        TOX_ERR_GROUP_PEER_QUERY_OK
        TOX_ERR_GROUP_PEER_QUERY_GROUP_NOT_FOUND
        TOX_ERR_GROUP_PEER_QUERY_PEER_NOT_FOUND
    cpdef enum Tox_Group_Privacy_State:
        TOX_GROUP_PRIVACY_STATE_PUBLIC
        TOX_GROUP_PRIVACY_STATE_PRIVATE
    cpdef enum Tox_Group_Topic_Lock:
        TOX_GROUP_TOPIC_LOCK_ENABLED
        TOX_GROUP_TOPIC_LOCK_DISABLED
    cpdef enum Tox_Group_Voice_State:
        TOX_GROUP_VOICE_STATE_ALL
        TOX_GROUP_VOICE_STATE_MODERATOR
        TOX_GROUP_VOICE_STATE_FOUNDER
    cpdef enum Tox_Group_Role:
        TOX_GROUP_ROLE_FOUNDER
        TOX_GROUP_ROLE_MODERATOR
        TOX_GROUP_ROLE_USER
        TOX_GROUP_ROLE_OBSERVER
    cpdef enum Tox_Err_Group_New:
        TOX_ERR_GROUP_NEW_OK
        TOX_ERR_GROUP_NEW_TOO_LONG
        TOX_ERR_GROUP_NEW_EMPTY
        TOX_ERR_GROUP_NEW_INIT
        TOX_ERR_GROUP_NEW_STATE
        TOX_ERR_GROUP_NEW_ANNOUNCE
    cpdef enum Tox_Err_Group_Join:
        TOX_ERR_GROUP_JOIN_OK
        TOX_ERR_GROUP_JOIN_INIT
        TOX_ERR_GROUP_JOIN_BAD_CHAT_ID
        TOX_ERR_GROUP_JOIN_EMPTY
        TOX_ERR_GROUP_JOIN_TOO_LONG
        TOX_ERR_GROUP_JOIN_PASSWORD
        TOX_ERR_GROUP_JOIN_CORE
    cpdef enum Tox_Err_Group_Is_Connected:
        TOX_ERR_GROUP_IS_CONNECTED_OK
        TOX_ERR_GROUP_IS_CONNECTED_GROUP_NOT_FOUND
    cpdef enum Tox_Err_Group_Disconnect:
        TOX_ERR_GROUP_DISCONNECT_OK
        TOX_ERR_GROUP_DISCONNECT_GROUP_NOT_FOUND
        TOX_ERR_GROUP_DISCONNECT_ALREADY_DISCONNECTED
    cpdef enum Tox_Err_Group_Reconnect:
        TOX_ERR_GROUP_RECONNECT_OK
        TOX_ERR_GROUP_RECONNECT_GROUP_NOT_FOUND
        TOX_ERR_GROUP_RECONNECT_CORE
    cpdef enum Tox_Err_Group_Leave:
        TOX_ERR_GROUP_LEAVE_OK
        TOX_ERR_GROUP_LEAVE_GROUP_NOT_FOUND
        TOX_ERR_GROUP_LEAVE_TOO_LONG
        TOX_ERR_GROUP_LEAVE_FAIL_SEND
    cpdef enum Tox_Err_Group_State_Queries:
        TOX_ERR_GROUP_STATE_QUERIES_OK
        TOX_ERR_GROUP_STATE_QUERIES_GROUP_NOT_FOUND
    cpdef enum Tox_Err_Group_Topic_Set:
        TOX_ERR_GROUP_TOPIC_SET_OK
        TOX_ERR_GROUP_TOPIC_SET_GROUP_NOT_FOUND
        TOX_ERR_GROUP_TOPIC_SET_TOO_LONG
        TOX_ERR_GROUP_TOPIC_SET_PERMISSIONS
        TOX_ERR_GROUP_TOPIC_SET_FAIL_CREATE
        TOX_ERR_GROUP_TOPIC_SET_FAIL_SEND
        TOX_ERR_GROUP_TOPIC_SET_DISCONNECTED
    cpdef enum Tox_Err_Group_Send_Message:
        TOX_ERR_GROUP_SEND_MESSAGE_OK
        TOX_ERR_GROUP_SEND_MESSAGE_GROUP_NOT_FOUND
        TOX_ERR_GROUP_SEND_MESSAGE_TOO_LONG
        TOX_ERR_GROUP_SEND_MESSAGE_EMPTY
        TOX_ERR_GROUP_SEND_MESSAGE_BAD_TYPE
        TOX_ERR_GROUP_SEND_MESSAGE_PERMISSIONS
        TOX_ERR_GROUP_SEND_MESSAGE_FAIL_SEND
        TOX_ERR_GROUP_SEND_MESSAGE_DISCONNECTED
    cpdef enum Tox_Err_Group_Send_Private_Message:
        TOX_ERR_GROUP_SEND_PRIVATE_MESSAGE_OK
        TOX_ERR_GROUP_SEND_PRIVATE_MESSAGE_GROUP_NOT_FOUND
        TOX_ERR_GROUP_SEND_PRIVATE_MESSAGE_PEER_NOT_FOUND
        TOX_ERR_GROUP_SEND_PRIVATE_MESSAGE_TOO_LONG
        TOX_ERR_GROUP_SEND_PRIVATE_MESSAGE_EMPTY
        TOX_ERR_GROUP_SEND_PRIVATE_MESSAGE_PERMISSIONS
        TOX_ERR_GROUP_SEND_PRIVATE_MESSAGE_FAIL_SEND
        TOX_ERR_GROUP_SEND_PRIVATE_MESSAGE_DISCONNECTED
        TOX_ERR_GROUP_SEND_PRIVATE_MESSAGE_BAD_TYPE
    cpdef enum Tox_Err_Group_Send_Custom_Packet:
        TOX_ERR_GROUP_SEND_CUSTOM_PACKET_OK
        TOX_ERR_GROUP_SEND_CUSTOM_PACKET_GROUP_NOT_FOUND
        TOX_ERR_GROUP_SEND_CUSTOM_PACKET_TOO_LONG
        TOX_ERR_GROUP_SEND_CUSTOM_PACKET_EMPTY
        TOX_ERR_GROUP_SEND_CUSTOM_PACKET_PERMISSIONS
        TOX_ERR_GROUP_SEND_CUSTOM_PACKET_DISCONNECTED
    cpdef enum Tox_Err_Group_Send_Custom_Private_Packet:
        TOX_ERR_GROUP_SEND_CUSTOM_PRIVATE_PACKET_OK
        TOX_ERR_GROUP_SEND_CUSTOM_PRIVATE_PACKET_GROUP_NOT_FOUND
        TOX_ERR_GROUP_SEND_CUSTOM_PRIVATE_PACKET_TOO_LONG
        TOX_ERR_GROUP_SEND_CUSTOM_PRIVATE_PACKET_EMPTY
        TOX_ERR_GROUP_SEND_CUSTOM_PRIVATE_PACKET_PEER_NOT_FOUND
        TOX_ERR_GROUP_SEND_CUSTOM_PRIVATE_PACKET_PERMISSIONS
        TOX_ERR_GROUP_SEND_CUSTOM_PRIVATE_PACKET_FAIL_SEND
        TOX_ERR_GROUP_SEND_CUSTOM_PRIVATE_PACKET_DISCONNECTED
    cpdef enum Tox_Err_Group_Invite_Friend:
        TOX_ERR_GROUP_INVITE_FRIEND_OK
        TOX_ERR_GROUP_INVITE_FRIEND_GROUP_NOT_FOUND
        TOX_ERR_GROUP_INVITE_FRIEND_FRIEND_NOT_FOUND
        TOX_ERR_GROUP_INVITE_FRIEND_INVITE_FAIL
        TOX_ERR_GROUP_INVITE_FRIEND_FAIL_SEND
        TOX_ERR_GROUP_INVITE_FRIEND_DISCONNECTED
    cpdef enum Tox_Err_Group_Invite_Accept:
        TOX_ERR_GROUP_INVITE_ACCEPT_OK
        TOX_ERR_GROUP_INVITE_ACCEPT_BAD_INVITE
        TOX_ERR_GROUP_INVITE_ACCEPT_INIT_FAILED
        TOX_ERR_GROUP_INVITE_ACCEPT_TOO_LONG
        TOX_ERR_GROUP_INVITE_ACCEPT_EMPTY
        TOX_ERR_GROUP_INVITE_ACCEPT_PASSWORD
        TOX_ERR_GROUP_INVITE_ACCEPT_CORE
        TOX_ERR_GROUP_INVITE_ACCEPT_FAIL_SEND
    cpdef enum Tox_Group_Exit_Type:
        TOX_GROUP_EXIT_TYPE_QUIT
        TOX_GROUP_EXIT_TYPE_TIMEOUT
        TOX_GROUP_EXIT_TYPE_DISCONNECTED
        TOX_GROUP_EXIT_TYPE_SELF_DISCONNECTED
        TOX_GROUP_EXIT_TYPE_KICK
        TOX_GROUP_EXIT_TYPE_SYNC_ERROR
    cpdef enum Tox_Group_Join_Fail:
        TOX_GROUP_JOIN_FAIL_PEER_LIMIT
        TOX_GROUP_JOIN_FAIL_INVALID_PASSWORD
        TOX_GROUP_JOIN_FAIL_UNKNOWN
    cpdef enum Tox_Err_Group_Set_Ignore:
        TOX_ERR_GROUP_SET_IGNORE_OK
        TOX_ERR_GROUP_SET_IGNORE_GROUP_NOT_FOUND
        TOX_ERR_GROUP_SET_IGNORE_PEER_NOT_FOUND
        TOX_ERR_GROUP_SET_IGNORE_SELF
    cpdef enum Tox_Err_Group_Founder_Set_Password:
        TOX_ERR_GROUP_FOUNDER_SET_PASSWORD_OK
        TOX_ERR_GROUP_FOUNDER_SET_PASSWORD_GROUP_NOT_FOUND
        TOX_ERR_GROUP_FOUNDER_SET_PASSWORD_PERMISSIONS
        TOX_ERR_GROUP_FOUNDER_SET_PASSWORD_TOO_LONG
        TOX_ERR_GROUP_FOUNDER_SET_PASSWORD_FAIL_SEND
        TOX_ERR_GROUP_FOUNDER_SET_PASSWORD_MALLOC
        TOX_ERR_GROUP_FOUNDER_SET_PASSWORD_DISCONNECTED
    cpdef enum Tox_Err_Group_Founder_Set_Topic_Lock:
        TOX_ERR_GROUP_FOUNDER_SET_TOPIC_LOCK_OK
        TOX_ERR_GROUP_FOUNDER_SET_TOPIC_LOCK_GROUP_NOT_FOUND
        TOX_ERR_GROUP_FOUNDER_SET_TOPIC_LOCK_INVALID
        TOX_ERR_GROUP_FOUNDER_SET_TOPIC_LOCK_PERMISSIONS
        TOX_ERR_GROUP_FOUNDER_SET_TOPIC_LOCK_FAIL_SET
        TOX_ERR_GROUP_FOUNDER_SET_TOPIC_LOCK_FAIL_SEND
        TOX_ERR_GROUP_FOUNDER_SET_TOPIC_LOCK_DISCONNECTED
    cpdef enum Tox_Err_Group_Founder_Set_Voice_State:
        TOX_ERR_GROUP_FOUNDER_SET_VOICE_STATE_OK
        TOX_ERR_GROUP_FOUNDER_SET_VOICE_STATE_GROUP_NOT_FOUND
        TOX_ERR_GROUP_FOUNDER_SET_VOICE_STATE_PERMISSIONS
        TOX_ERR_GROUP_FOUNDER_SET_VOICE_STATE_FAIL_SET
        TOX_ERR_GROUP_FOUNDER_SET_VOICE_STATE_FAIL_SEND
        TOX_ERR_GROUP_FOUNDER_SET_VOICE_STATE_DISCONNECTED
    cpdef enum Tox_Err_Group_Founder_Set_Privacy_State:
        TOX_ERR_GROUP_FOUNDER_SET_PRIVACY_STATE_OK
        TOX_ERR_GROUP_FOUNDER_SET_PRIVACY_STATE_GROUP_NOT_FOUND
        TOX_ERR_GROUP_FOUNDER_SET_PRIVACY_STATE_PERMISSIONS
        TOX_ERR_GROUP_FOUNDER_SET_PRIVACY_STATE_FAIL_SET
        TOX_ERR_GROUP_FOUNDER_SET_PRIVACY_STATE_FAIL_SEND
        TOX_ERR_GROUP_FOUNDER_SET_PRIVACY_STATE_DISCONNECTED
    cpdef enum Tox_Err_Group_Founder_Set_Peer_Limit:
        TOX_ERR_GROUP_FOUNDER_SET_PEER_LIMIT_OK
        TOX_ERR_GROUP_FOUNDER_SET_PEER_LIMIT_GROUP_NOT_FOUND
        TOX_ERR_GROUP_FOUNDER_SET_PEER_LIMIT_PERMISSIONS
        TOX_ERR_GROUP_FOUNDER_SET_PEER_LIMIT_FAIL_SET
        TOX_ERR_GROUP_FOUNDER_SET_PEER_LIMIT_FAIL_SEND
        TOX_ERR_GROUP_FOUNDER_SET_PEER_LIMIT_DISCONNECTED
    cpdef enum Tox_Err_Group_Mod_Set_Role:
        TOX_ERR_GROUP_MOD_SET_ROLE_OK
        TOX_ERR_GROUP_MOD_SET_ROLE_GROUP_NOT_FOUND
        TOX_ERR_GROUP_MOD_SET_ROLE_PEER_NOT_FOUND
        TOX_ERR_GROUP_MOD_SET_ROLE_PERMISSIONS
        TOX_ERR_GROUP_MOD_SET_ROLE_ASSIGNMENT
        TOX_ERR_GROUP_MOD_SET_ROLE_FAIL_ACTION
        TOX_ERR_GROUP_MOD_SET_ROLE_SELF
    cpdef enum Tox_Err_Group_Mod_Kick_Peer:
        TOX_ERR_GROUP_MOD_KICK_PEER_OK
        TOX_ERR_GROUP_MOD_KICK_PEER_GROUP_NOT_FOUND
        TOX_ERR_GROUP_MOD_KICK_PEER_PEER_NOT_FOUND
        TOX_ERR_GROUP_MOD_KICK_PEER_PERMISSIONS
        TOX_ERR_GROUP_MOD_KICK_PEER_FAIL_ACTION
        TOX_ERR_GROUP_MOD_KICK_PEER_FAIL_SEND
        TOX_ERR_GROUP_MOD_KICK_PEER_SELF
    cpdef enum Tox_Group_Mod_Event:
        TOX_GROUP_MOD_EVENT_KICK
        TOX_GROUP_MOD_EVENT_OBSERVER
        TOX_GROUP_MOD_EVENT_USER
        TOX_GROUP_MOD_EVENT_MODERATOR
    ctypedef struct Tox_System
    ctypedef struct Tox_Options
    ctypedef struct Tox
    ctypedef uint32_t Tox_Friend_Number
    ctypedef uint32_t Tox_Friend_Message_Id
    ctypedef uint32_t Tox_File_Number
    ctypedef uint32_t Tox_Conference_Peer_Number
    ctypedef uint32_t Tox_Conference_Number
    ctypedef uint32_t Tox_Group_Peer_Number
    ctypedef uint32_t Tox_Group_Number
    ctypedef uint32_t Tox_Group_Message_Id
    ctypedef void tox_log_cb(Tox* tox, Tox_Log_Level level, const char* file, uint32_t line, const char* func, const char* message, void* user_data)
    ctypedef void tox_self_connection_status_cb(Tox* tox, Tox_Connection connection_status, void* user_data)
    ctypedef void tox_friend_name_cb(Tox* tox, Tox_Friend_Number friend_number, const uint8_t* name, size_t length, void* user_data)
    ctypedef void tox_friend_status_message_cb(Tox* tox, Tox_Friend_Number friend_number, const uint8_t* message, size_t length, void* user_data)
    ctypedef void tox_friend_status_cb(Tox* tox, Tox_Friend_Number friend_number, Tox_User_Status status, void* user_data)
    ctypedef void tox_friend_connection_status_cb(Tox* tox, Tox_Friend_Number friend_number, Tox_Connection connection_status, void* user_data)
    ctypedef void tox_friend_typing_cb(Tox* tox, Tox_Friend_Number friend_number, bool typing, void* user_data)
    ctypedef void tox_friend_read_receipt_cb(Tox* tox, Tox_Friend_Number friend_number, Tox_Friend_Message_Id message_id, void* user_data)
    ctypedef void tox_friend_request_cb(Tox* tox, const uint8_t* public_key, const uint8_t* message, size_t length, void* user_data)
    ctypedef void tox_friend_message_cb(Tox* tox, Tox_Friend_Number friend_number, Tox_Message_Type type, const uint8_t* message, size_t length, void* user_data)
    ctypedef void tox_friend_lossy_packet_cb(Tox* tox, Tox_Friend_Number friend_number, const uint8_t* data, size_t length, void* user_data)
    ctypedef void tox_friend_lossless_packet_cb(Tox* tox, Tox_Friend_Number friend_number, const uint8_t* data, size_t length, void* user_data)
    ctypedef void tox_file_recv_control_cb(Tox* tox, Tox_Friend_Number friend_number, Tox_File_Number file_number, Tox_File_Control control, void* user_data)
    ctypedef void tox_file_chunk_request_cb(Tox* tox, Tox_Friend_Number friend_number, Tox_File_Number file_number, uint64_t position, size_t length, void* user_data)
    ctypedef void tox_file_recv_cb(Tox* tox, Tox_Friend_Number friend_number, Tox_File_Number file_number, uint32_t kind, uint64_t file_size, const uint8_t* filename, size_t filename_length, void* user_data)
    ctypedef void tox_file_recv_chunk_cb(Tox* tox, Tox_Friend_Number friend_number, Tox_File_Number file_number, uint64_t position, const uint8_t* data, size_t length, void* user_data)
    ctypedef void tox_conference_peer_name_cb(Tox* tox, Tox_Conference_Number conference_number, Tox_Conference_Peer_Number peer_number, const uint8_t* name, size_t length, void* user_data)
    ctypedef void tox_conference_peer_list_changed_cb(Tox* tox, Tox_Conference_Number conference_number, void* user_data)
    ctypedef void tox_conference_invite_cb(Tox* tox, Tox_Friend_Number friend_number, Tox_Conference_Type type, const uint8_t* cookie, size_t length, void* user_data)
    ctypedef void tox_conference_connected_cb(Tox* tox, Tox_Conference_Number conference_number, void* user_data)
    ctypedef void tox_conference_message_cb(Tox* tox, Tox_Conference_Number conference_number, Tox_Conference_Peer_Number peer_number, Tox_Message_Type type, const uint8_t* message, size_t length, void* user_data)
    ctypedef void tox_conference_title_cb(Tox* tox, Tox_Conference_Number conference_number, Tox_Conference_Peer_Number peer_number, const uint8_t* title, size_t length, void* user_data)
    ctypedef void tox_group_self_join_cb(Tox* tox, Tox_Group_Number group_number, void* user_data)
    ctypedef void tox_group_peer_name_cb(Tox* tox, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id, const uint8_t* name, size_t length, void* user_data)
    ctypedef void tox_group_peer_status_cb(Tox* tox, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id, Tox_User_Status status, void* user_data)
    ctypedef void tox_group_peer_limit_cb(Tox* tox, Tox_Group_Number group_number, uint32_t peer_limit, void* user_data)
    ctypedef void tox_group_peer_join_cb(Tox* tox, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id, void* user_data)
    ctypedef void tox_group_peer_exit_cb(Tox* tox, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id, Tox_Group_Exit_Type exit_type, const uint8_t* name, size_t name_length, const uint8_t* part_message, size_t part_message_length, void* user_data)
    ctypedef void tox_group_topic_cb(Tox* tox, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id, const uint8_t* topic, size_t length, void* user_data)
    ctypedef void tox_group_privacy_state_cb(Tox* tox, Tox_Group_Number group_number, Tox_Group_Privacy_State privacy_state, void* user_data)
    ctypedef void tox_group_voice_state_cb(Tox* tox, Tox_Group_Number group_number, Tox_Group_Voice_State voice_state, void* user_data)
    ctypedef void tox_group_topic_lock_cb(Tox* tox, Tox_Group_Number group_number, Tox_Group_Topic_Lock topic_lock, void* user_data)
    ctypedef void tox_group_password_cb(Tox* tox, Tox_Group_Number group_number, const uint8_t* password, size_t length, void* user_data)
    ctypedef void tox_group_message_cb(Tox* tox, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id, Tox_Message_Type type, const uint8_t* message, size_t length, Tox_Group_Message_Id message_id, void* user_data)
    ctypedef void tox_group_private_message_cb(Tox* tox, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id, Tox_Message_Type type, const uint8_t* message, size_t length, void* user_data)
    ctypedef void tox_group_custom_packet_cb(Tox* tox, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id, const uint8_t* data, size_t length, void* user_data)
    ctypedef void tox_group_custom_private_packet_cb(Tox* tox, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id, const uint8_t* data, size_t length, void* user_data)
    ctypedef void tox_group_invite_cb(Tox* tox, Tox_Friend_Number friend_number, const uint8_t* invite_data, size_t length, const uint8_t* group_name, size_t group_name_length, void* user_data)
    ctypedef void tox_group_join_fail_cb(Tox* tox, Tox_Group_Number group_number, Tox_Group_Join_Fail fail_type, void* user_data)
    ctypedef void tox_group_moderation_cb(Tox* tox, Tox_Group_Number group_number, Tox_Group_Peer_Number source_peer_id, Tox_Group_Peer_Number target_peer_id, Tox_Group_Mod_Event mod_type, void* user_data)
    cdef bool tox_options_get_ipv6_enabled(const Tox_Options* self)
    cdef void tox_options_set_ipv6_enabled(Tox_Options* self, bool ipv6_enabled)
    cdef bool tox_options_get_udp_enabled(const Tox_Options* self)
    cdef void tox_options_set_udp_enabled(Tox_Options* self, bool udp_enabled)
    cdef bool tox_options_get_local_discovery_enabled(const Tox_Options* self)
    cdef void tox_options_set_local_discovery_enabled(Tox_Options* self, bool local_discovery_enabled)
    cdef bool tox_options_get_dht_announcements_enabled(const Tox_Options* self)
    cdef void tox_options_set_dht_announcements_enabled(Tox_Options* self, bool dht_announcements_enabled)
    cdef Tox_Proxy_Type tox_options_get_proxy_type(const Tox_Options* self)
    cdef void tox_options_set_proxy_type(Tox_Options* self, Tox_Proxy_Type proxy_type)
    cdef const char* tox_options_get_proxy_host(const Tox_Options* self)
    cdef void tox_options_set_proxy_host(Tox_Options* self, const char* proxy_host)
    cdef uint16_t tox_options_get_proxy_port(const Tox_Options* self)
    cdef void tox_options_set_proxy_port(Tox_Options* self, uint16_t proxy_port)
    cdef uint16_t tox_options_get_start_port(const Tox_Options* self)
    cdef void tox_options_set_start_port(Tox_Options* self, uint16_t start_port)
    cdef uint16_t tox_options_get_end_port(const Tox_Options* self)
    cdef void tox_options_set_end_port(Tox_Options* self, uint16_t end_port)
    cdef uint16_t tox_options_get_tcp_port(const Tox_Options* self)
    cdef void tox_options_set_tcp_port(Tox_Options* self, uint16_t tcp_port)
    cdef bool tox_options_get_hole_punching_enabled(const Tox_Options* self)
    cdef void tox_options_set_hole_punching_enabled(Tox_Options* self, bool hole_punching_enabled)
    cdef Tox_Savedata_Type tox_options_get_savedata_type(const Tox_Options* self)
    cdef void tox_options_set_savedata_type(Tox_Options* self, Tox_Savedata_Type savedata_type)
    cdef void tox_options_set_savedata_data(Tox_Options* self, const uint8_t* savedata_data, size_t length)
    cdef bool tox_options_get_experimental_thread_safety(const Tox_Options* self)
    cdef void tox_options_set_experimental_thread_safety(Tox_Options* self, bool experimental_thread_safety)
    cdef void tox_options_default(Tox_Options* self)
    cdef Tox_Options* tox_options_new(Tox_Err_Options_New* error)
    cdef void tox_options_free(Tox_Options* self)
    cdef void tox_get_savedata(const Tox* self, uint8_t* savedata)
    cdef size_t tox_get_savedata_size(const Tox* self)
    cdef uint32_t tox_version_major()
    cdef uint32_t tox_version_minor()
    cdef uint32_t tox_version_patch()
    cdef bool tox_version_is_compatible(uint32_t major, uint32_t minor, uint32_t patch)
    cdef uint32_t tox_public_key_size()
    cdef uint32_t tox_secret_key_size()
    cdef uint32_t tox_nospam_size()
    cdef uint32_t tox_address_size()
    cdef uint32_t tox_max_name_length()
    cdef uint32_t tox_max_status_message_length()
    cdef uint32_t tox_max_friend_request_length()
    cdef uint32_t tox_max_message_length()
    cdef uint32_t tox_max_custom_packet_size()
    cdef uint32_t tox_hash_length()
    cdef uint32_t tox_max_filename_length()
    cdef uint32_t tox_max_hostname_length()
    cdef Tox* tox_new(const Tox_Options* options, Tox_Err_New* error)
    cdef void tox_kill(Tox* self)
    cdef bool tox_bootstrap(Tox* self, const char* host, uint16_t port, const uint8_t* public_key, Tox_Err_Bootstrap* error)
    cdef bool tox_add_tcp_relay(Tox* self, const char* host, uint16_t port, const uint8_t* public_key, Tox_Err_Bootstrap* error)
    cdef uint32_t tox_iteration_interval(const Tox* self)
    cdef void tox_iterate(Tox* self, void* user_data)
    cdef bool tox_hash(uint8_t* hash, const uint8_t* data, size_t length)
    cdef Tox_Connection tox_self_get_connection_status(const Tox* self)
    cdef void tox_self_get_address(const Tox* self, uint8_t* address)
    cdef uint32_t tox_self_get_nospam(const Tox* self)
    cdef void tox_self_set_nospam(Tox* self, uint32_t nospam)
    cdef void tox_self_get_public_key(const Tox* self, uint8_t* public_key)
    cdef void tox_self_get_secret_key(const Tox* self, uint8_t* secret_key)
    cdef void tox_self_get_name(const Tox* self, uint8_t* name)
    cdef bool tox_self_set_name(Tox* self, const uint8_t* name, size_t length, Tox_Err_Set_Info* error)
    cdef size_t tox_self_get_name_size(const Tox* self)
    cdef void tox_self_get_status_message(const Tox* self, uint8_t* status_message)
    cdef bool tox_self_set_status_message(Tox* self, const uint8_t* status_message, size_t length, Tox_Err_Set_Info* error)
    cdef size_t tox_self_get_status_message_size(const Tox* self)
    cdef Tox_User_Status tox_self_get_status(const Tox* self)
    cdef void tox_self_set_status(Tox* self, Tox_User_Status status)
    cdef void tox_self_get_friend_list(const Tox* self, Tox_Friend_Number* friend_list)
    cdef size_t tox_self_get_friend_list_size(const Tox* self)
    cdef bool tox_self_set_typing(Tox* self, Tox_Friend_Number friend_number, bool typing, Tox_Err_Set_Typing* error)
    cdef void tox_self_get_dht_id(const Tox* self, uint8_t* dht_id)
    cdef uint16_t tox_self_get_udp_port(const Tox* self, Tox_Err_Get_Port* error)
    cdef uint16_t tox_self_get_tcp_port(const Tox* self, Tox_Err_Get_Port* error)
    cdef void tox_callback_self_connection_status(Tox* self, tox_self_connection_status_cb* callback)
    cdef bool tox_friend_get_public_key(const Tox* self, Tox_Friend_Number friend_number, uint8_t* public_key, Tox_Err_Friend_Get_Public_Key* error)
    cdef uint64_t tox_friend_get_last_online(const Tox* self, Tox_Friend_Number friend_number, Tox_Err_Friend_Get_Last_Online* error)
    cdef bool tox_friend_get_name(const Tox* self, Tox_Friend_Number friend_number, uint8_t* name, Tox_Err_Friend_Query* error)
    cdef size_t tox_friend_get_name_size(const Tox* self, Tox_Friend_Number friend_number, Tox_Err_Friend_Query* error)
    cdef bool tox_friend_get_status_message(const Tox* self, Tox_Friend_Number friend_number, uint8_t* status_message, Tox_Err_Friend_Query* error)
    cdef size_t tox_friend_get_status_message_size(const Tox* self, Tox_Friend_Number friend_number, Tox_Err_Friend_Query* error)
    cdef Tox_User_Status tox_friend_get_status(const Tox* self, Tox_Friend_Number friend_number, Tox_Err_Friend_Query* error)
    cdef Tox_Connection tox_friend_get_connection_status(const Tox* self, Tox_Friend_Number friend_number, Tox_Err_Friend_Query* error)
    cdef bool tox_friend_get_typing(const Tox* self, Tox_Friend_Number friend_number, Tox_Err_Friend_Query* error)
    cdef Tox_Friend_Number tox_friend_add(Tox* self, const uint8_t* address, const uint8_t* message, size_t length, Tox_Err_Friend_Add* error)
    cdef Tox_Friend_Number tox_friend_add_norequest(Tox* self, const uint8_t* public_key, Tox_Err_Friend_Add* error)
    cdef bool tox_friend_delete(Tox* self, Tox_Friend_Number friend_number, Tox_Err_Friend_Delete* error)
    cdef Tox_Friend_Number tox_friend_by_public_key(const Tox* self, const uint8_t* public_key, Tox_Err_Friend_By_Public_Key* error)
    cdef bool tox_friend_exists(const Tox* self, Tox_Friend_Number friend_number)
    cdef void tox_callback_friend_name(Tox* self, tox_friend_name_cb* callback)
    cdef void tox_callback_friend_status_message(Tox* self, tox_friend_status_message_cb* callback)
    cdef void tox_callback_friend_status(Tox* self, tox_friend_status_cb* callback)
    cdef void tox_callback_friend_connection_status(Tox* self, tox_friend_connection_status_cb* callback)
    cdef void tox_callback_friend_typing(Tox* self, tox_friend_typing_cb* callback)
    cdef Tox_Friend_Message_Id tox_friend_send_message(Tox* self, Tox_Friend_Number friend_number, Tox_Message_Type type, const uint8_t* message, size_t length, Tox_Err_Friend_Send_Message* error)
    cdef void tox_callback_friend_read_receipt(Tox* self, tox_friend_read_receipt_cb* callback)
    cdef void tox_callback_friend_request(Tox* self, tox_friend_request_cb* callback)
    cdef void tox_callback_friend_message(Tox* self, tox_friend_message_cb* callback)
    cdef bool tox_friend_send_lossy_packet(Tox* self, Tox_Friend_Number friend_number, const uint8_t* data, size_t length, Tox_Err_Friend_Custom_Packet* error)
    cdef bool tox_friend_send_lossless_packet(Tox* self, Tox_Friend_Number friend_number, const uint8_t* data, size_t length, Tox_Err_Friend_Custom_Packet* error)
    cdef void tox_callback_friend_lossy_packet(Tox* self, tox_friend_lossy_packet_cb* callback)
    cdef void tox_callback_friend_lossless_packet(Tox* self, tox_friend_lossless_packet_cb* callback)
    cdef bool tox_file_get_file_id(const Tox* self, Tox_Friend_Number friend_number, Tox_File_Number file_number, uint8_t* file_id, Tox_Err_File_Get* error)
    cdef uint32_t tox_file_id_length()
    cdef bool tox_file_control(Tox* self, Tox_Friend_Number friend_number, Tox_File_Number file_number, Tox_File_Control control, Tox_Err_File_Control* error)
    cdef void tox_callback_file_recv_control(Tox* self, tox_file_recv_control_cb* callback)
    cdef bool tox_file_seek(Tox* self, Tox_Friend_Number friend_number, Tox_File_Number file_number, uint64_t position, Tox_Err_File_Seek* error)
    cdef Tox_File_Number tox_file_send(Tox* self, Tox_Friend_Number friend_number, uint32_t kind, uint64_t file_size, const uint8_t* file_id, const uint8_t* filename, size_t filename_length, Tox_Err_File_Send* error)
    cdef bool tox_file_send_chunk(Tox* self, Tox_Friend_Number friend_number, Tox_File_Number file_number, uint64_t position, const uint8_t* data, size_t length, Tox_Err_File_Send_Chunk* error)
    cdef void tox_callback_file_chunk_request(Tox* self, tox_file_chunk_request_cb* callback)
    cdef void tox_callback_file_recv(Tox* self, tox_file_recv_cb* callback)
    cdef void tox_callback_file_recv_chunk(Tox* self, tox_file_recv_chunk_cb* callback)
    cdef bool tox_conference_peer_get_name(const Tox* self, Tox_Conference_Number conference_number, Tox_Conference_Peer_Number peer_number, uint8_t* name, Tox_Err_Conference_Peer_Query* error)
    cdef size_t tox_conference_peer_get_name_size(const Tox* self, Tox_Conference_Number conference_number, Tox_Conference_Peer_Number peer_number, Tox_Err_Conference_Peer_Query* error)
    cdef bool tox_conference_peer_get_public_key(const Tox* self, Tox_Conference_Number conference_number, Tox_Conference_Peer_Number peer_number, uint8_t* public_key, Tox_Err_Conference_Peer_Query* error)
    cdef void tox_callback_conference_peer_name(Tox* self, tox_conference_peer_name_cb* callback)
    cdef void tox_callback_conference_peer_list_changed(Tox* self, tox_conference_peer_list_changed_cb* callback)
    cdef Tox_Conference_Peer_Number tox_conference_peer_count(const Tox* self, Tox_Conference_Number conference_number, Tox_Err_Conference_Peer_Query* error)
    cdef bool tox_conference_peer_number_is_ours(const Tox* self, Tox_Conference_Number conference_number, Tox_Conference_Peer_Number peer_number, Tox_Err_Conference_Peer_Query* error)
    cdef bool tox_conference_offline_peer_get_name(const Tox* self, Tox_Conference_Number conference_number, Tox_Conference_Peer_Number offline_peer_number, uint8_t* name, Tox_Err_Conference_Peer_Query* error)
    cdef size_t tox_conference_offline_peer_get_name_size(const Tox* self, Tox_Conference_Number conference_number, Tox_Conference_Peer_Number offline_peer_number, Tox_Err_Conference_Peer_Query* error)
    cdef bool tox_conference_offline_peer_get_public_key(const Tox* self, Tox_Conference_Number conference_number, Tox_Conference_Peer_Number offline_peer_number, uint8_t* public_key, Tox_Err_Conference_Peer_Query* error)
    cdef uint64_t tox_conference_offline_peer_get_last_active(const Tox* self, Tox_Conference_Number conference_number, Tox_Conference_Peer_Number offline_peer_number, Tox_Err_Conference_Peer_Query* error)
    cdef uint32_t tox_conference_offline_peer_count(const Tox* self, Tox_Conference_Number conference_number, Tox_Err_Conference_Peer_Query* error)
    cdef bool tox_conference_set_max_offline(Tox* self, Tox_Conference_Number conference_number, uint32_t max_offline, Tox_Err_Conference_Set_Max_Offline* error)
    cdef bool tox_conference_get_title(const Tox* self, Tox_Conference_Number conference_number, uint8_t* title, Tox_Err_Conference_Title* error)
    cdef bool tox_conference_set_title(Tox* self, Tox_Conference_Number conference_number, const uint8_t* title, size_t length, Tox_Err_Conference_Title* error)
    cdef size_t tox_conference_get_title_size(const Tox* self, Tox_Conference_Number conference_number, Tox_Err_Conference_Title* error)
    cdef void tox_conference_get_chatlist(const Tox* self, Tox_Conference_Number* chatlist)
    cdef size_t tox_conference_get_chatlist_size(const Tox* self)
    cdef Tox_Conference_Type tox_conference_get_type(const Tox* self, Tox_Conference_Number conference_number, Tox_Err_Conference_Get_Type* error)
    cdef bool tox_conference_get_id(const Tox* self, Tox_Conference_Number conference_number, uint8_t* id)
    cdef bool tox_conference_get_uid(const Tox* self, Tox_Conference_Number conference_number, uint8_t* uid)
    cdef uint32_t tox_conference_uid_size()
    cdef uint32_t tox_conference_id_size()
    cdef void tox_callback_conference_invite(Tox* self, tox_conference_invite_cb* callback)
    cdef void tox_callback_conference_connected(Tox* self, tox_conference_connected_cb* callback)
    cdef void tox_callback_conference_message(Tox* self, tox_conference_message_cb* callback)
    cdef void tox_callback_conference_title(Tox* self, tox_conference_title_cb* callback)
    cdef Tox_Conference_Number tox_conference_new(Tox* self, Tox_Err_Conference_New* error)
    cdef bool tox_conference_delete(Tox* self, Tox_Conference_Number conference_number, Tox_Err_Conference_Delete* error)
    cdef bool tox_conference_invite(Tox* self, Tox_Friend_Number friend_number, Tox_Conference_Number conference_number, Tox_Err_Conference_Invite* error)
    cdef Tox_Conference_Number tox_conference_join(Tox* self, Tox_Friend_Number friend_number, const uint8_t* cookie, size_t length, Tox_Err_Conference_Join* error)
    cdef bool tox_conference_send_message(Tox* self, Tox_Conference_Number conference_number, Tox_Message_Type type, const uint8_t* message, size_t length, Tox_Err_Conference_Send_Message* error)
    cdef Tox_Conference_Number tox_conference_by_id(const Tox* self, const uint8_t* id, Tox_Err_Conference_By_Id* error)
    cdef Tox_Conference_Number tox_conference_by_uid(const Tox* self, const uint8_t* uid, Tox_Err_Conference_By_Uid* error)
    cdef bool tox_group_self_get_name(const Tox* self, Tox_Group_Number group_number, uint8_t* name, Tox_Err_Group_Self_Query* error)
    cdef bool tox_group_self_set_name(Tox* self, Tox_Group_Number group_number, const uint8_t* name, size_t length, Tox_Err_Group_Self_Name_Set* error)
    cdef size_t tox_group_self_get_name_size(const Tox* self, Tox_Group_Number group_number, Tox_Err_Group_Self_Query* error)
    cdef Tox_User_Status tox_group_self_get_status(const Tox* self, Tox_Group_Number group_number, Tox_Err_Group_Self_Query* error)
    cdef bool tox_group_self_set_status(Tox* self, Tox_Group_Number group_number, Tox_User_Status status, Tox_Err_Group_Self_Status_Set* error)
    cdef Tox_Group_Role tox_group_self_get_role(const Tox* self, Tox_Group_Number group_number, Tox_Err_Group_Self_Query* error)
    cdef Tox_Group_Peer_Number tox_group_self_get_peer_id(const Tox* self, Tox_Group_Number group_number, Tox_Err_Group_Self_Query* error)
    cdef bool tox_group_self_get_public_key(const Tox* self, Tox_Group_Number group_number, uint8_t* public_key, Tox_Err_Group_Self_Query* error)
    cdef void tox_callback_group_self_join(Tox* self, tox_group_self_join_cb* callback)
    cdef bool tox_group_peer_get_name(const Tox* self, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id, uint8_t* name, Tox_Err_Group_Peer_Query* error)
    cdef size_t tox_group_peer_get_name_size(const Tox* self, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id, Tox_Err_Group_Peer_Query* error)
    cdef Tox_User_Status tox_group_peer_get_status(const Tox* self, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id, Tox_Err_Group_Peer_Query* error)
    cdef Tox_Group_Role tox_group_peer_get_role(const Tox* self, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id, Tox_Err_Group_Peer_Query* error)
    cdef Tox_Connection tox_group_peer_get_connection_status(const Tox* self, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id, Tox_Err_Group_Peer_Query* error)
    cdef bool tox_group_peer_get_public_key(const Tox* self, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id, uint8_t* public_key, Tox_Err_Group_Peer_Query* error)
    cdef uint32_t tox_group_peer_public_key_size()
    cdef void tox_callback_group_peer_name(Tox* self, tox_group_peer_name_cb* callback)
    cdef void tox_callback_group_peer_status(Tox* self, tox_group_peer_status_cb* callback)
    cdef void tox_callback_group_peer_limit(Tox* self, tox_group_peer_limit_cb* callback)
    cdef void tox_callback_group_peer_join(Tox* self, tox_group_peer_join_cb* callback)
    cdef void tox_callback_group_peer_exit(Tox* self, tox_group_peer_exit_cb* callback)
    cdef bool tox_group_get_topic(const Tox* self, Tox_Group_Number group_number, uint8_t* topic, Tox_Err_Group_State_Queries* error)
    cdef bool tox_group_set_topic(Tox* self, Tox_Group_Number group_number, const uint8_t* topic, size_t length, Tox_Err_Group_Topic_Set* error)
    cdef size_t tox_group_get_topic_size(const Tox* self, Tox_Group_Number group_number, Tox_Err_Group_State_Queries* error)
    cdef bool tox_group_get_name(const Tox* self, Tox_Group_Number group_number, uint8_t* name, Tox_Err_Group_State_Queries* error)
    cdef size_t tox_group_get_name_size(const Tox* self, Tox_Group_Number group_number, Tox_Err_Group_State_Queries* error)
    cdef bool tox_group_get_chat_id(const Tox* self, Tox_Group_Number group_number, uint8_t* chat_id, Tox_Err_Group_State_Queries* error)
    cdef uint32_t tox_group_get_number_groups(const Tox* self)
    cdef Tox_Group_Privacy_State tox_group_get_privacy_state(const Tox* self, Tox_Group_Number group_number, Tox_Err_Group_State_Queries* error)
    cdef Tox_Group_Voice_State tox_group_get_voice_state(const Tox* self, Tox_Group_Number group_number, Tox_Err_Group_State_Queries* error)
    cdef Tox_Group_Topic_Lock tox_group_get_topic_lock(const Tox* self, Tox_Group_Number group_number, Tox_Err_Group_State_Queries* error)
    cdef uint16_t tox_group_get_peer_limit(const Tox* self, Tox_Group_Number group_number, Tox_Err_Group_State_Queries* error)
    cdef bool tox_group_get_password(const Tox* self, Tox_Group_Number group_number, uint8_t* password, Tox_Err_Group_State_Queries* error)
    cdef size_t tox_group_get_password_size(const Tox* self, Tox_Group_Number group_number, Tox_Err_Group_State_Queries* error)
    cdef bool tox_group_set_ignore(Tox* self, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id, bool ignore, Tox_Err_Group_Set_Ignore* error)
    cdef uint32_t tox_group_max_topic_length()
    cdef uint32_t tox_group_max_part_length()
    cdef uint32_t tox_group_max_message_length()
    cdef uint32_t tox_group_max_custom_lossy_packet_length()
    cdef uint32_t tox_group_max_custom_lossless_packet_length()
    cdef uint32_t tox_group_max_group_name_length()
    cdef uint32_t tox_group_max_password_size()
    cdef uint32_t tox_group_chat_id_size()
    cdef Tox_Group_Number tox_group_new(Tox* self, Tox_Group_Privacy_State privacy_state, const uint8_t* group_name, size_t group_name_length, const uint8_t* name, size_t name_length, Tox_Err_Group_New* error)
    cdef Tox_Group_Number tox_group_join(Tox* self, const uint8_t* chat_id, const uint8_t* name, size_t name_length, const uint8_t* password, size_t password_length, Tox_Err_Group_Join* error)
    cdef bool tox_group_is_connected(const Tox* self, Tox_Group_Number group_number, Tox_Err_Group_Is_Connected* error)
    cdef bool tox_group_disconnect(const Tox* self, Tox_Group_Number group_number, Tox_Err_Group_Disconnect* error)
    cdef bool tox_group_reconnect(Tox* self, Tox_Group_Number group_number, Tox_Err_Group_Reconnect* error)
    cdef bool tox_group_leave(Tox* self, Tox_Group_Number group_number, const uint8_t* part_message, size_t length, Tox_Err_Group_Leave* error)
    cdef void tox_callback_group_topic(Tox* self, tox_group_topic_cb* callback)
    cdef void tox_callback_group_privacy_state(Tox* self, tox_group_privacy_state_cb* callback)
    cdef void tox_callback_group_voice_state(Tox* self, tox_group_voice_state_cb* callback)
    cdef void tox_callback_group_topic_lock(Tox* self, tox_group_topic_lock_cb* callback)
    cdef void tox_callback_group_password(Tox* self, tox_group_password_cb* callback)
    cdef Tox_Group_Message_Id tox_group_send_message(const Tox* self, Tox_Group_Number group_number, Tox_Message_Type type, const uint8_t* message, size_t length, Tox_Err_Group_Send_Message* error)
    cdef bool tox_group_send_private_message(const Tox* self, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id, Tox_Message_Type type, const uint8_t* message, size_t length, Tox_Err_Group_Send_Private_Message* error)
    cdef bool tox_group_send_custom_packet(const Tox* self, Tox_Group_Number group_number, bool lossless, const uint8_t* data, size_t length, Tox_Err_Group_Send_Custom_Packet* error)
    cdef bool tox_group_send_custom_private_packet(const Tox* self, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id, bool lossless, const uint8_t* data, size_t length, Tox_Err_Group_Send_Custom_Private_Packet* error)
    cdef void tox_callback_group_message(Tox* self, tox_group_message_cb* callback)
    cdef void tox_callback_group_private_message(Tox* self, tox_group_private_message_cb* callback)
    cdef void tox_callback_group_custom_packet(Tox* self, tox_group_custom_packet_cb* callback)
    cdef void tox_callback_group_custom_private_packet(Tox* self, tox_group_custom_private_packet_cb* callback)
    cdef bool tox_group_invite_friend(const Tox* self, Tox_Group_Number group_number, Tox_Friend_Number friend_number, Tox_Err_Group_Invite_Friend* error)
    cdef Tox_Group_Number tox_group_invite_accept(Tox* self, Tox_Friend_Number friend_number, const uint8_t* invite_data, size_t length, const uint8_t* name, size_t name_length, const uint8_t* password, size_t password_length, Tox_Err_Group_Invite_Accept* error)
    cdef void tox_callback_group_invite(Tox* self, tox_group_invite_cb* callback)
    cdef void tox_callback_group_join_fail(Tox* self, tox_group_join_fail_cb* callback)
    cdef void tox_callback_group_moderation(Tox* self, tox_group_moderation_cb* callback)
    cdef bool tox_group_founder_set_password(Tox* self, Tox_Group_Number group_number, const uint8_t* password, size_t length, Tox_Err_Group_Founder_Set_Password* error)
    cdef bool tox_group_founder_set_topic_lock(Tox* self, Tox_Group_Number group_number, Tox_Group_Topic_Lock topic_lock, Tox_Err_Group_Founder_Set_Topic_Lock* error)
    cdef bool tox_group_founder_set_voice_state(Tox* self, Tox_Group_Number group_number, Tox_Group_Voice_State voice_state, Tox_Err_Group_Founder_Set_Voice_State* error)
    cdef bool tox_group_founder_set_privacy_state(Tox* self, Tox_Group_Number group_number, Tox_Group_Privacy_State privacy_state, Tox_Err_Group_Founder_Set_Privacy_State* error)
    cdef bool tox_group_founder_set_peer_limit(Tox* self, Tox_Group_Number group_number, uint16_t peer_limit, Tox_Err_Group_Founder_Set_Peer_Limit* error)
    cdef bool tox_group_mod_set_role(Tox* self, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id, Tox_Group_Role role, Tox_Err_Group_Mod_Set_Role* error)
    cdef bool tox_group_mod_kick_peer(const Tox* self, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id, Tox_Err_Group_Mod_Kick_Peer* error)

# cython: language_level=3

cdef void handle_self_connection_status(Tox* tox, Tox_Connection connection_status, void* user_data) noexcept:
    (<Tox_Ptr> user_data).handle_self_connection_status(Tox_Connection(connection_status))
cdef void handle_friend_name(Tox *tox,
    Tox_Friend_Number friend_number,
    const uint8_t name[], size_t length, void* user_data) noexcept:
    (<Tox_Ptr> user_data).handle_friend_name(friend_number, name, length)
cdef void handle_friend_status_message(
    Tox* tox, Tox_Friend_Number friend_number,
    const uint8_t message[], size_t length, void* user_data) noexcept:
    (<Tox_Ptr> user_data).handle_friend_status_message(friend_number, message, length)
cdef void handle_friend_status(
    Tox* tox, Tox_Friend_Number friend_number, Tox_User_Status status, void* user_data) noexcept:
    (<Tox_Ptr> user_data).handle_friend_status(friend_number, Tox_User_Status(status))
cdef void handle_friend_connection_status(
    Tox* tox, Tox_Friend_Number friend_number, Tox_Connection connection_status, void* user_data) noexcept:
    (<Tox_Ptr> user_data).handle_friend_connection_status(friend_number, Tox_Connection(connection_status))
cdef void handle_friend_typing(
    Tox* tox, Tox_Friend_Number friend_number, bool typing, void* user_data) noexcept:
    (<Tox_Ptr> user_data).handle_friend_typing(friend_number, typing)
cdef void handle_friend_read_receipt(
    Tox* tox, Tox_Friend_Number friend_number, Tox_Friend_Message_Id message_id, void* user_data) noexcept:
    (<Tox_Ptr> user_data).handle_friend_read_receipt(friend_number, message_id)
cdef void handle_friend_request(
    Tox* tox, const uint8_t public_key[],
    const uint8_t message[], size_t length,
    void* user_data) noexcept:
    (<Tox_Ptr> user_data).handle_friend_request(public_key, message, length)
cdef void handle_friend_message(
    Tox* tox, Tox_Friend_Number friend_number, Tox_Message_Type type,
    const uint8_t message[], size_t length, void* user_data) noexcept:
    (<Tox_Ptr> user_data).handle_friend_message(friend_number, Tox_Message_Type(type), message, length)
cdef void handle_file_recv_control(
    Tox* tox, Tox_Friend_Number friend_number, Tox_File_Number file_number, Tox_File_Control control,
    void* user_data) noexcept:
    (<Tox_Ptr> user_data).handle_file_recv_control(friend_number, file_number, Tox_File_Control(control))
cdef void handle_file_chunk_request(
    Tox* tox, Tox_Friend_Number friend_number, Tox_File_Number file_number, uint64_t position,
    size_t length, void* user_data) noexcept:
    (<Tox_Ptr> user_data).handle_file_chunk_request(friend_number, file_number, position, length)
cdef void handle_file_recv(
    Tox* tox, Tox_Friend_Number friend_number, Tox_File_Number file_number, uint32_t kind, uint64_t file_size,
    const uint8_t filename[], size_t filename_length, void* user_data) noexcept:
    (<Tox_Ptr> user_data).handle_file_recv(friend_number, file_number, kind, file_size, filename, filename_length)
cdef void handle_file_recv_chunk(
    Tox* tox, Tox_Friend_Number friend_number, Tox_File_Number file_number, uint64_t position,
    const uint8_t data[], size_t length, void* user_data) noexcept:
    (<Tox_Ptr> user_data).handle_file_recv_chunk(friend_number, file_number, position, data, length)
cdef void handle_conference_invite(
    Tox* tox, Tox_Friend_Number friend_number, Tox_Conference_Type type,
    const uint8_t cookie[], size_t length, void* user_data) noexcept:
    (<Tox_Ptr> user_data).handle_conference_invite(friend_number, Tox_Conference_Type(type), cookie, length)
cdef void handle_conference_connected(Tox* tox, Tox_Conference_Number conference_number, void* user_data) noexcept:
    (<Tox_Ptr> user_data).handle_conference_connected(conference_number)
cdef void handle_conference_message(
    Tox* tox, Tox_Conference_Number conference_number, Tox_Conference_Peer_Number peer_number,
    Tox_Message_Type type, const uint8_t message[], size_t length, void* user_data) noexcept:
    (<Tox_Ptr> user_data).handle_conference_message(conference_number, peer_number, Tox_Message_Type(type), message, length)
cdef void handle_conference_title(
    Tox* tox, Tox_Conference_Number conference_number, Tox_Conference_Peer_Number peer_number,
    const uint8_t title[], size_t length, void* user_data) noexcept:
    (<Tox_Ptr> user_data).handle_conference_title(conference_number, peer_number, title, length)
cdef void handle_conference_peer_name(
    Tox* tox, Tox_Conference_Number conference_number, Tox_Conference_Peer_Number peer_number,
    const uint8_t name[], size_t length, void* user_data) noexcept:
    (<Tox_Ptr> user_data).handle_conference_peer_name(conference_number, peer_number, name, length)
cdef void handle_conference_peer_list_changed(Tox* tox, Tox_Conference_Number conference_number, void* user_data) noexcept:
    (<Tox_Ptr> user_data).handle_conference_peer_list_changed(conference_number)
cdef void handle_friend_lossy_packet(
    Tox* tox, Tox_Friend_Number friend_number,
    const uint8_t data[], size_t length,
    void* user_data) noexcept:
    (<Tox_Ptr> user_data).handle_friend_lossy_packet(friend_number, data, length)
cdef void handle_friend_lossless_packet(
    Tox* tox, Tox_Friend_Number friend_number,
    const uint8_t data[], size_t length,
    void* user_data) noexcept:
    (<Tox_Ptr> user_data).handle_friend_lossless_packet(friend_number, data, length)
cdef void handle_group_peer_name(
    Tox* tox, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id,
    const uint8_t name[], size_t length, void* user_data) noexcept:
    (<Tox_Ptr> user_data).handle_group_peer_name(group_number, peer_id, name, length)
cdef void handle_group_peer_status(Tox* tox, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id, Tox_User_Status status,
    void* user_data) noexcept:
    (<Tox_Ptr> user_data).handle_group_peer_status(group_number, peer_id, Tox_User_Status(status))
cdef void handle_group_topic(
    Tox* tox, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id,
    const uint8_t topic[], size_t length,
    void* user_data) noexcept:
    (<Tox_Ptr> user_data).handle_group_topic(group_number, peer_id, topic, length)
cdef void handle_group_privacy_state(Tox* tox, Tox_Group_Number group_number, Tox_Group_Privacy_State privacy_state,
    void* user_data) noexcept:
    (<Tox_Ptr> user_data).handle_group_privacy_state(group_number, Tox_Group_Privacy_State(privacy_state))
cdef void handle_group_voice_state(Tox* tox, Tox_Group_Number group_number, Tox_Group_Voice_State voice_state,
    void* user_data) noexcept:
    (<Tox_Ptr> user_data).handle_group_voice_state(group_number, Tox_Group_Voice_State(voice_state))
cdef void handle_group_topic_lock(Tox* tox, Tox_Group_Number group_number, Tox_Group_Topic_Lock topic_lock, void* user_data) noexcept:
    (<Tox_Ptr> user_data).handle_group_topic_lock(group_number, Tox_Group_Topic_Lock(topic_lock))
cdef void handle_group_peer_limit(Tox* tox, Tox_Group_Number group_number, uint32_t peer_limit, void* user_data) noexcept:
    (<Tox_Ptr> user_data).handle_group_peer_limit(group_number, peer_limit)
cdef void handle_group_password(
    Tox* tox, Tox_Group_Number group_number,
    const uint8_t password[], size_t length,
    void* user_data) noexcept:
    (<Tox_Ptr> user_data).handle_group_password(group_number, password, length)
cdef void handle_group_message(
    Tox* tox, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id, Tox_Message_Type type,
    const uint8_t message[], size_t length, Tox_Group_Message_Id message_id, void* user_data) noexcept:
    (<Tox_Ptr> user_data).handle_group_message(group_number, peer_id, Tox_Message_Type(type), message, length, message_id)
cdef void handle_group_private_message(
    Tox* tox, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id, Tox_Message_Type type,
    const uint8_t message[], size_t length, void* user_data) noexcept:
    (<Tox_Ptr> user_data).handle_group_private_message(group_number, peer_id, Tox_Message_Type(type), message, length)
cdef void handle_group_custom_packet(
    Tox* tox, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id,
    const uint8_t data[], size_t length, void* user_data) noexcept:
    (<Tox_Ptr> user_data).handle_group_custom_packet(group_number, peer_id, data, length)
cdef void handle_group_custom_private_packet(
    Tox* tox, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id,
    const uint8_t data[], size_t length, void* user_data) noexcept:
    (<Tox_Ptr> user_data).handle_group_custom_private_packet(group_number, peer_id, data, length)
cdef void handle_group_invite(
    Tox* tox, Tox_Friend_Number friend_number,
    const uint8_t invite_data[], size_t length,
    const uint8_t group_name[], size_t group_name_length,
    void* user_data) noexcept:
    (<Tox_Ptr> user_data).handle_group_invite(friend_number, invite_data, length, group_name, group_name_length)
cdef void handle_group_peer_join(Tox* tox, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id, void* user_data) noexcept:
    (<Tox_Ptr> user_data).handle_group_peer_join(group_number, peer_id)
cdef void handle_group_peer_exit(
    Tox* tox, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id, Tox_Group_Exit_Type exit_type,
    const uint8_t name[], size_t name_length,
    const uint8_t part_message[], size_t part_message_length, void* user_data) noexcept:
    (<Tox_Ptr> user_data).handle_group_peer_exit(group_number, peer_id, Tox_Group_Exit_Type(exit_type), name, name_length, part_message, part_message_length)
cdef void handle_group_self_join(Tox* tox, Tox_Group_Number group_number, void* user_data) noexcept:
    (<Tox_Ptr> user_data).handle_group_self_join(group_number)
cdef void handle_group_join_fail(Tox* tox, Tox_Group_Number group_number, Tox_Group_Join_Fail fail_type, void* user_data) noexcept:
    (<Tox_Ptr> user_data).handle_group_join_fail(group_number, Tox_Group_Join_Fail(fail_type))
cdef void handle_group_moderation(
    Tox* tox, Tox_Group_Number group_number, Tox_Group_Peer_Number source_peer_id, Tox_Group_Peer_Number target_peer_id,
    Tox_Group_Mod_Event mod_type, void* user_data) noexcept:
    (<Tox_Ptr> user_data).handle_group_moderation(group_number, source_peer_id, target_peer_id, Tox_Group_Mod_Event(mod_type))

cdef void install_handlers(Tox *ptr):
    tox_callback_self_connection_status(ptr, handle_self_connection_status)
    tox_callback_friend_name(ptr, handle_friend_name)
    tox_callback_friend_status_message(ptr, handle_friend_status_message)
    tox_callback_friend_status(ptr, handle_friend_status)
    tox_callback_friend_connection_status(ptr, handle_friend_connection_status)
    tox_callback_friend_typing(ptr, handle_friend_typing)
    tox_callback_friend_read_receipt(ptr, handle_friend_read_receipt)
    tox_callback_friend_request(ptr, handle_friend_request)
    tox_callback_friend_message(ptr, handle_friend_message)
    tox_callback_file_recv_control(ptr, handle_file_recv_control)
    tox_callback_file_chunk_request(ptr, handle_file_chunk_request)
    tox_callback_file_recv(ptr, handle_file_recv)
    tox_callback_file_recv_chunk(ptr, handle_file_recv_chunk)
    tox_callback_conference_invite(ptr, handle_conference_invite)
    tox_callback_conference_connected(ptr, handle_conference_connected)
    tox_callback_conference_message(ptr, handle_conference_message)
    tox_callback_conference_title(ptr, handle_conference_title)
    tox_callback_conference_peer_name(ptr, handle_conference_peer_name)
    tox_callback_conference_peer_list_changed(ptr, handle_conference_peer_list_changed)
    tox_callback_friend_lossy_packet(ptr, handle_friend_lossy_packet)
    tox_callback_friend_lossless_packet(ptr, handle_friend_lossless_packet)
    tox_callback_group_peer_name(ptr, handle_group_peer_name)
    tox_callback_group_peer_status(ptr, handle_group_peer_status)
    tox_callback_group_topic(ptr, handle_group_topic)
    tox_callback_group_privacy_state(ptr, handle_group_privacy_state)
    tox_callback_group_voice_state(ptr, handle_group_voice_state)
    tox_callback_group_topic_lock(ptr, handle_group_topic_lock)
    tox_callback_group_peer_limit(ptr, handle_group_peer_limit)
    tox_callback_group_password(ptr, handle_group_password)
    tox_callback_group_message(ptr, handle_group_message)
    tox_callback_group_private_message(ptr, handle_group_private_message)
    tox_callback_group_custom_packet(ptr, handle_group_custom_packet)
    tox_callback_group_custom_private_packet(ptr, handle_group_custom_private_packet)
    tox_callback_group_invite(ptr, handle_group_invite)
    tox_callback_group_peer_join(ptr, handle_group_peer_join)
    tox_callback_group_peer_exit(ptr, handle_group_peer_exit)
    tox_callback_group_self_join(ptr, handle_group_self_join)
    tox_callback_group_join_fail(ptr, handle_group_join_fail)
    tox_callback_group_moderation(ptr, handle_group_moderation)


VERSION: str = "%d.%d.%d" % (tox_version_major(), tox_version_minor(), tox_version_patch())

PUBLIC_KEY_SIZE: int = tox_public_key_size()
SECRET_KEY_SIZE: int = tox_secret_key_size()
CONFERENCE_UID_SIZE: int = tox_conference_uid_size()
CONFERENCE_ID_SIZE: int = tox_conference_id_size()
NOSPAM_SIZE: int = tox_nospam_size()
ADDRESS_SIZE: int = tox_address_size()
MAX_NAME_LENGTH: int = tox_max_name_length()
MAX_STATUS_MESSAGE_LENGTH: int = tox_max_status_message_length()
MAX_FRIEND_REQUEST_LENGTH: int = tox_max_friend_request_length()
MAX_MESSAGE_LENGTH: int = tox_max_message_length()
MAX_CUSTOM_PACKET_SIZE: int = tox_max_custom_packet_size()
HASH_LENGTH: int = tox_hash_length()
FILE_ID_LENGTH: int = tox_file_id_length()
MAX_FILENAME_LENGTH: int = tox_max_filename_length()
MAX_HOSTNAME_LENGTH: int = tox_max_hostname_length()


class UseAfterFreeException(Exception):
    def __init__(self):
        super().__init__(
                "object used after it was killed/freed (or it was never initialised)")

class ToxException(Exception):
    pass

class ApiException(ToxException):
    def __init__(self, err):
        super().__init__(err)
        self.error = err

class LengthException(ToxException):
    pass

cdef void _check_len(str name, bytes data, int expected_length) except *:
    if len(data) != expected_length:
        raise LengthException(
                f"parameter '{name}' received bytes of invalid"
                f"length {len(data)}, expected {expected_length}")


cdef class Tox_Options_Ptr:

    cdef Tox_Options *_get(self) except *:
        if self._ptr is NULL:
            raise UseAfterFreeException()
        return self._ptr

    @staticmethod
    cdef Tox_Options* _new():
        cdef Tox_Err_Options_New err = TOX_ERR_OPTIONS_NEW_OK
        cdef Tox_Options *ptr = tox_options_new(&err)
        if err: raise ApiException(Tox_Err_Options_New(err))
        return ptr

    def __init__(self):
        self._ptr = Tox_Options_Ptr._new()

    def __dealloc__(self):
        self.__exit__(None, None, None)

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_value, exc_traceback):
        tox_options_free(self._ptr)
        self._ptr = NULL

    @property
    def ipv6_enabled(self) -> bool:
        return tox_options_get_ipv6_enabled(self._get())

    @ipv6_enabled.setter
    def ipv6_enabled(self, value: bool):
        tox_options_set_ipv6_enabled(self._get(), value)


cdef class Tox_Ptr:

    cdef Tox *_get(self) except *:
        if self._ptr is NULL:
            raise UseAfterFreeException()
        return self._ptr

    @staticmethod
    cdef Tox* _new(options: Tox_Options_Ptr):
        cdef Tox_Err_New err = TOX_ERR_NEW_OK
        cdef Tox* ptr = tox_new(options._get() if options else NULL, &err)
        if err: raise ApiException(Tox_Err_New(err))
        install_handlers(ptr)
        return ptr

    def __init__(self, options: Tox_Options_Ptr = None):
        self._ptr = Tox_Ptr._new(options)

    def __dealloc__(self):
        self.__exit__(None, None, None)

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_value, exc_traceback):
        tox_kill(self._ptr)
        self._ptr = NULL

    @property
    def savedata(self) -> bytes:
        cdef size_t size = tox_get_savedata_size(self._get())
        cdef uint8_t *data = <uint8_t*> malloc(size * sizeof(uint8_t))
        try:
            tox_get_savedata(self._get(), data)
            return data[:size]
        finally:
            free(data)

    def bootstrap(self, host: str, port: int, public_key: bytes) -> bool:
        _check_len("public_key", public_key, tox_public_key_size())
        cdef Tox_Err_Bootstrap err = TOX_ERR_BOOTSTRAP_OK
        return tox_bootstrap(self._get(), host.encode("utf-8"), port, public_key, &err)

    @property
    def connection_status(self) -> Tox_Connection:
        return Tox_Connection(tox_self_get_connection_status(self._get()))

    @property
    def iteration_interval(self) -> int:
        return tox_iteration_interval(self._get())

    def iterate(self) -> None:
        return tox_iterate(self._get(), <void*>self)

    @property
    def address(self) -> bytes:
        cdef size_t size = tox_address_size()
        cdef uint8_t *data = <uint8_t*> malloc(size * sizeof(uint8_t))
        try:
            tox_self_get_address(self._get(), data)
            return data[:size]
        finally:
            free(data)

    @property
    def nospam(self) -> int:
        return tox_self_get_nospam(self._get())

    @property
    def public_key(self) -> bytes:
        cdef size_t size = tox_public_key_size()
        cdef uint8_t *data = <uint8_t*> malloc(size * sizeof(uint8_t))
        try:
            tox_self_get_public_key(self._get(), data)
            return data[:tox_public_key_size()]
        finally:
            free(data)

    @property
    def secret_key(self) -> bytes:
        cdef size_t size = tox_secret_key_size()
        cdef uint8_t *data = <uint8_t*> malloc(size * sizeof(uint8_t))
        try:
            tox_self_get_secret_key(self._get(), data)
            return data[:tox_secret_key_size()]
        finally:
            free(data)

    @property
    def name(self) -> bytes:
        cdef size_t size = tox_self_get_name_size(self._get())
        cdef uint8_t *data = <uint8_t*> malloc(size * sizeof(uint8_t))
        try:
            tox_self_get_name(self._get(), data)
            return data[:size]
        finally:
            free(data)

    @name.setter
    def name(self, name: bytes) -> None:
        cdef Tox_Err_Set_Info err = TOX_ERR_SET_INFO_OK
        tox_self_set_name(self._get(), name, len(name), &err)
        if err: raise ApiException(Tox_Err_Set_Info(err))

    @property
    def status_message(self) -> bytes:
        cdef size_t size = tox_self_get_status_message_size(self._get())
        cdef uint8_t *data = <uint8_t*> malloc(size * sizeof(uint8_t))
        try:
            tox_self_get_status_message(self._get(), data)
            return data[:size]
        finally:
            free(data)

    @status_message.setter
    def status_message(self, status_message: bytes) -> None:
        cdef Tox_Err_Set_Info err = TOX_ERR_SET_INFO_OK
        tox_self_set_status_message(self._get(), status_message, len(status_message), &err)
        if err: raise ApiException(Tox_Err_Set_Info(err))

    @property
    def status(self) -> Tox_User_Status:
        return tox_self_get_status(self._get())

    @status.setter
    def status(self, status: Tox_User_Status) -> None:
        tox_self_set_status(self._get(), status)

    def friend_add(self, address: bytes, message: bytes):
        _check_len("address", address, tox_address_size())
        cdef Tox_Err_Friend_Add err = TOX_ERR_FRIEND_ADD_OK
        tox_friend_add(self._get(), address, message, len(message), &err)
        if err: raise ApiException(Tox_Err_Friend_Add(err))

    def friend_add_norequest(self, public_key: bytes):
        _check_len("public_key", public_key, tox_public_key_size())
        cdef Tox_Err_Friend_Add err = TOX_ERR_FRIEND_ADD_OK
        tox_friend_add_norequest(self._get(), public_key, &err)
        if err: raise ApiException(Tox_Err_Friend_Add(err))

    def friend_delete(self, friend_number: int):
        cdef Tox_Err_Friend_Delete err = TOX_ERR_FRIEND_DELETE_OK
        tox_friend_delete(self._get(), friend_number, &err)
        if err: raise ApiException(Tox_Err_Friend_Delete(err))

    def handle_self_connection_status(self, connection_status: Tox_Connection) -> None:
        pass
    def handle_friend_name(Tox_Ptr self, Tox_Friend_Number friend_number, const uint8_t name[], size_t length) -> None:
        pass
    def handle_friend_status_message(Tox_Ptr self, Tox_Friend_Number friend_number, const uint8_t message[], size_t length) -> None:
        pass
    def handle_friend_status(Tox_Ptr self, Tox_Friend_Number friend_number, Tox_User_Status status) -> None:
        pass
    def handle_friend_connection_status(Tox_Ptr self, Tox_Friend_Number friend_number, Tox_Connection connection_status) -> None:
        pass
    def handle_friend_typing(Tox_Ptr self, Tox_Friend_Number friend_number, bool typing) -> None:
        pass
    def handle_friend_read_receipt(Tox_Ptr self, Tox_Friend_Number friend_number, Tox_Friend_Message_Id message_id) -> None:
        pass
    def handle_friend_request(Tox_Ptr self, const uint8_t public_key[],const uint8_t message[], size_t length) -> None:
        pass
    def handle_friend_message(Tox_Ptr self, Tox_Friend_Number friend_number, Tox_Message_Type type,const uint8_t message[], size_t length) -> None:
        pass
    def handle_file_recv_control(Tox_Ptr self, Tox_Friend_Number friend_number, Tox_File_Number file_number, Tox_File_Control control) -> None:
        pass
    def handle_file_chunk_request(Tox_Ptr self, Tox_Friend_Number friend_number, Tox_File_Number file_number, uint64_t position,size_t length) -> None:
        pass
    def handle_file_recv(Tox_Ptr self, Tox_Friend_Number friend_number, Tox_File_Number file_number, uint32_t kind, uint64_t file_size,const uint8_t filename[], size_t filename_length) -> None:
        pass
    def handle_file_recv_chunk(Tox_Ptr self, Tox_Friend_Number friend_number, Tox_File_Number file_number, uint64_t position,const uint8_t data[], size_t length) -> None:
        pass
    def handle_conference_invite(Tox_Ptr self, Tox_Friend_Number friend_number, Tox_Conference_Type type,const uint8_t cookie[], size_t length) -> None:
        pass
    def handle_conference_connected(Tox_Ptr self, Tox_Conference_Number conference_number) -> None:
        pass
    def handle_conference_message(Tox_Ptr self, Tox_Conference_Number conference_number, Tox_Conference_Peer_Number peer_number,Tox_Message_Type type, const uint8_t message[], size_t length) -> None:
        pass
    def handle_conference_title(Tox_Ptr self, Tox_Conference_Number conference_number, Tox_Conference_Peer_Number peer_number,const uint8_t title[], size_t length) -> None:
        pass
    def handle_conference_peer_name(Tox_Ptr self, Tox_Conference_Number conference_number, Tox_Conference_Peer_Number peer_number,const uint8_t name[], size_t length) -> None:
        pass
    def handle_conference_peer_list_changed(Tox_Ptr self, Tox_Conference_Number conference_number) -> None:
        pass
    def handle_friend_lossy_packet(Tox_Ptr self, Tox_Friend_Number friend_number,const uint8_t data[], size_t length) -> None:
        pass
    def handle_friend_lossless_packet(Tox_Ptr self, Tox_Friend_Number friend_number,const uint8_t data[], size_t length) -> None:
        pass
    def handle_group_peer_name(Tox_Ptr self, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id,const uint8_t name[], size_t length) -> None:
        pass
    def handle_group_peer_status(Tox_Ptr self, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id, Tox_User_Status status) -> None:
        pass
    def handle_group_topic(Tox_Ptr self, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id,const uint8_t topic[], size_t length) -> None:
        pass
    def handle_group_privacy_state(Tox_Ptr self, Tox_Group_Number group_number, Tox_Group_Privacy_State privacy_state) -> None:
        pass
    def handle_group_voice_state(Tox_Ptr self, Tox_Group_Number group_number, Tox_Group_Voice_State voice_state) -> None:
        pass
    def handle_group_topic_lock(Tox_Ptr self, Tox_Group_Number group_number, Tox_Group_Topic_Lock topic_lock) -> None:
        pass
    def handle_group_peer_limit(Tox_Ptr self, Tox_Group_Number group_number, uint32_t peer_limit) -> None:
        pass
    def handle_group_password(Tox_Ptr self, Tox_Group_Number group_number,const uint8_t password[], size_t length) -> None:
        pass
    def handle_group_message(Tox_Ptr self, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id, Tox_Message_Type type,const uint8_t message[], size_t length, Tox_Group_Message_Id message_id) -> None:
        pass
    def handle_group_private_message(Tox_Ptr self, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id, Tox_Message_Type type,const uint8_t message[], size_t length) -> None:
        pass
    def handle_group_custom_packet(Tox_Ptr self, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id,const uint8_t data[], size_t length) -> None:
        pass
    def handle_group_custom_private_packet(Tox_Ptr self, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id,const uint8_t data[], size_t length) -> None:
        pass
    def handle_group_invite(Tox_Ptr self, Tox_Friend_Number friend_number,const uint8_t invite_data[], size_t length,const uint8_t group_name[], size_t group_name_length) -> None:
        pass
    def handle_group_peer_join(Tox_Ptr self, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id) -> None:
        pass
    def handle_group_peer_exit(Tox_Ptr self, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id, Tox_Group_Exit_Type exit_type,const uint8_t name[], size_t name_length,const uint8_t part_message[], size_t part_message_length) -> None:
        pass
    def handle_group_self_join(Tox_Ptr self, Tox_Group_Number group_number) -> None:
        pass
    def handle_group_join_fail(Tox_Ptr self, Tox_Group_Number group_number, Tox_Group_Join_Fail fail_type) -> None:
        pass
    def handle_group_moderation(Tox_Ptr self, Tox_Group_Number group_number, Tox_Group_Peer_Number source_peer_id, Tox_Group_Peer_Number target_peer_id,Tox_Group_Mod_Event mod_type) -> None:
        pass

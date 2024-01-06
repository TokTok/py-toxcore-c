# cython: language_level=3, linetrace=True
from array import array
from pytox import common

class ApiException(common.ApiException): pass

cdef:
    void py_handle_self_connection_status(self: Tox_Ptr, connection_status: Tox_Connection) except *:
        self.handle_self_connection_status(connection_status)
    void handle_self_connection_status(Tox* tox, Tox_Connection connection_status, void* user_data) except *:
        py_handle_self_connection_status(<Tox_Ptr> user_data, Tox_Connection(connection_status))
    void py_handle_friend_name(self: Tox_Ptr, friend_number: Tox_Friend_Number, name: bytes) except *:
        self.handle_friend_name(friend_number, name)
    void handle_friend_name(Tox* tox, Tox_Friend_Number friend_number, const uint8_t* name, size_t length, void* user_data) except *:
        py_handle_friend_name(<Tox_Ptr> user_data, friend_number, name[:length])
    void py_handle_friend_status_message(self: Tox_Ptr, friend_number: Tox_Friend_Number, message: bytes) except *:
        self.handle_friend_status_message(friend_number, message)
    void handle_friend_status_message(Tox* tox, Tox_Friend_Number friend_number, const uint8_t* message, size_t length, void* user_data) except *:
        py_handle_friend_status_message(<Tox_Ptr> user_data, friend_number, message[:length])
    void py_handle_friend_status(self: Tox_Ptr, friend_number: Tox_Friend_Number, status: Tox_User_Status) except *:
        self.handle_friend_status(friend_number, status)
    void handle_friend_status(Tox* tox, Tox_Friend_Number friend_number, Tox_User_Status status, void* user_data) except *:
        py_handle_friend_status(<Tox_Ptr> user_data, friend_number, Tox_User_Status(status))
    void py_handle_friend_connection_status(self: Tox_Ptr, friend_number: Tox_Friend_Number, connection_status: Tox_Connection) except *:
        self.handle_friend_connection_status(friend_number, connection_status)
    void handle_friend_connection_status(Tox* tox, Tox_Friend_Number friend_number, Tox_Connection connection_status, void* user_data) except *:
        py_handle_friend_connection_status(<Tox_Ptr> user_data, friend_number, Tox_Connection(connection_status))
    void py_handle_friend_typing(self: Tox_Ptr, friend_number: Tox_Friend_Number, typing: bool) except *:
        self.handle_friend_typing(friend_number, typing)
    void handle_friend_typing(Tox* tox, Tox_Friend_Number friend_number, bool typing, void* user_data) except *:
        py_handle_friend_typing(<Tox_Ptr> user_data, friend_number, typing)
    void py_handle_friend_read_receipt(self: Tox_Ptr, friend_number: Tox_Friend_Number, message_id: Tox_Friend_Message_Id) except *:
        self.handle_friend_read_receipt(friend_number, message_id)
    void handle_friend_read_receipt(Tox* tox, Tox_Friend_Number friend_number, Tox_Friend_Message_Id message_id, void* user_data) except *:
        py_handle_friend_read_receipt(<Tox_Ptr> user_data, friend_number, message_id)
    void py_handle_friend_request(self: Tox_Ptr, public_key: bytes, message: bytes) except *:
        self.handle_friend_request(public_key, message)
    void handle_friend_request(Tox* tox, const uint8_t* public_key, const uint8_t* message, size_t length, void* user_data) except *:
        py_handle_friend_request(<Tox_Ptr> user_data, public_key[:tox_public_key_size()], message[:length])
    void py_handle_friend_message(self: Tox_Ptr, friend_number: Tox_Friend_Number, type_: Tox_Message_Type, message: bytes) except *:
        self.handle_friend_message(friend_number, type_, message)
    void handle_friend_message(Tox* tox, Tox_Friend_Number friend_number, Tox_Message_Type type_, const uint8_t* message, size_t length, void* user_data) except *:
        py_handle_friend_message(<Tox_Ptr> user_data, friend_number, Tox_Message_Type(type_), message[:length])
    void py_handle_friend_lossy_packet(self: Tox_Ptr, friend_number: Tox_Friend_Number, data: bytes) except *:
        self.handle_friend_lossy_packet(friend_number, data)
    void handle_friend_lossy_packet(Tox* tox, Tox_Friend_Number friend_number, const uint8_t* data, size_t length, void* user_data) except *:
        py_handle_friend_lossy_packet(<Tox_Ptr> user_data, friend_number, data[:length])
    void py_handle_friend_lossless_packet(self: Tox_Ptr, friend_number: Tox_Friend_Number, data: bytes) except *:
        self.handle_friend_lossless_packet(friend_number, data)
    void handle_friend_lossless_packet(Tox* tox, Tox_Friend_Number friend_number, const uint8_t* data, size_t length, void* user_data) except *:
        py_handle_friend_lossless_packet(<Tox_Ptr> user_data, friend_number, data[:length])
    void py_handle_file_recv_control(self: Tox_Ptr, friend_number: Tox_Friend_Number, file_number: Tox_File_Number, control: Tox_File_Control) except *:
        self.handle_file_recv_control(friend_number, file_number, control)
    void handle_file_recv_control(Tox* tox, Tox_Friend_Number friend_number, Tox_File_Number file_number, Tox_File_Control control, void* user_data) except *:
        py_handle_file_recv_control(<Tox_Ptr> user_data, friend_number, file_number, Tox_File_Control(control))
    void py_handle_file_chunk_request(self: Tox_Ptr, friend_number: Tox_Friend_Number, file_number: Tox_File_Number, position: int, length: int) except *:
        self.handle_file_chunk_request(friend_number, file_number, position, length)
    void handle_file_chunk_request(Tox* tox, Tox_Friend_Number friend_number, Tox_File_Number file_number, uint64_t position, size_t length, void* user_data) except *:
        py_handle_file_chunk_request(<Tox_Ptr> user_data, friend_number, file_number, position, length)
    void py_handle_file_recv(self: Tox_Ptr, friend_number: Tox_Friend_Number, file_number: Tox_File_Number, kind: int, file_size: int, filename: bytes) except *:
        self.handle_file_recv(friend_number, file_number, kind, file_size, filename)
    void handle_file_recv(Tox* tox, Tox_Friend_Number friend_number, Tox_File_Number file_number, uint32_t kind, uint64_t file_size, const uint8_t* filename, size_t filename_length, void* user_data) except *:
        py_handle_file_recv(<Tox_Ptr> user_data, friend_number, file_number, kind, file_size, filename[:filename_length])
    void py_handle_file_recv_chunk(self: Tox_Ptr, friend_number: Tox_Friend_Number, file_number: Tox_File_Number, position: int, data: bytes) except *:
        self.handle_file_recv_chunk(friend_number, file_number, position, data)
    void handle_file_recv_chunk(Tox* tox, Tox_Friend_Number friend_number, Tox_File_Number file_number, uint64_t position, const uint8_t* data, size_t length, void* user_data) except *:
        py_handle_file_recv_chunk(<Tox_Ptr> user_data, friend_number, file_number, position, data[:length])
    void py_handle_conference_peer_name(self: Tox_Ptr, conference_number: Tox_Conference_Number, peer_number: Tox_Conference_Peer_Number, name: bytes) except *:
        self.handle_conference_peer_name(conference_number, peer_number, name)
    void handle_conference_peer_name(Tox* tox, Tox_Conference_Number conference_number, Tox_Conference_Peer_Number peer_number, const uint8_t* name, size_t length, void* user_data) except *:
        py_handle_conference_peer_name(<Tox_Ptr> user_data, conference_number, peer_number, name[:length])
    void py_handle_conference_peer_list_changed(self: Tox_Ptr, conference_number: Tox_Conference_Number) except *:
        self.handle_conference_peer_list_changed(conference_number)
    void handle_conference_peer_list_changed(Tox* tox, Tox_Conference_Number conference_number, void* user_data) except *:
        py_handle_conference_peer_list_changed(<Tox_Ptr> user_data, conference_number)
    void py_handle_conference_invite(self: Tox_Ptr, friend_number: Tox_Friend_Number, type_: Tox_Conference_Type, cookie: bytes) except *:
        self.handle_conference_invite(friend_number, type_, cookie)
    void handle_conference_invite(Tox* tox, Tox_Friend_Number friend_number, Tox_Conference_Type type_, const uint8_t* cookie, size_t length, void* user_data) except *:
        py_handle_conference_invite(<Tox_Ptr> user_data, friend_number, Tox_Conference_Type(type_), cookie[:length])
    void py_handle_conference_connected(self: Tox_Ptr, conference_number: Tox_Conference_Number) except *:
        self.handle_conference_connected(conference_number)
    void handle_conference_connected(Tox* tox, Tox_Conference_Number conference_number, void* user_data) except *:
        py_handle_conference_connected(<Tox_Ptr> user_data, conference_number)
    void py_handle_conference_message(self: Tox_Ptr, conference_number: Tox_Conference_Number, peer_number: Tox_Conference_Peer_Number, type_: Tox_Message_Type, message: bytes) except *:
        self.handle_conference_message(conference_number, peer_number, type_, message)
    void handle_conference_message(Tox* tox, Tox_Conference_Number conference_number, Tox_Conference_Peer_Number peer_number, Tox_Message_Type type_, const uint8_t* message, size_t length, void* user_data) except *:
        py_handle_conference_message(<Tox_Ptr> user_data, conference_number, peer_number, Tox_Message_Type(type_), message[:length])
    void py_handle_conference_title(self: Tox_Ptr, conference_number: Tox_Conference_Number, peer_number: Tox_Conference_Peer_Number, title: bytes) except *:
        self.handle_conference_title(conference_number, peer_number, title)
    void handle_conference_title(Tox* tox, Tox_Conference_Number conference_number, Tox_Conference_Peer_Number peer_number, const uint8_t* title, size_t length, void* user_data) except *:
        py_handle_conference_title(<Tox_Ptr> user_data, conference_number, peer_number, title[:length])
    void py_handle_group_self_join(self: Tox_Ptr, group_number: Tox_Group_Number) except *:
        self.handle_group_self_join(group_number)
    void handle_group_self_join(Tox* tox, Tox_Group_Number group_number, void* user_data) except *:
        py_handle_group_self_join(<Tox_Ptr> user_data, group_number)
    void py_handle_group_peer_name(self: Tox_Ptr, group_number: Tox_Group_Number, peer_id: Tox_Group_Peer_Number, name: bytes) except *:
        self.handle_group_peer_name(group_number, peer_id, name)
    void handle_group_peer_name(Tox* tox, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id, const uint8_t* name, size_t length, void* user_data) except *:
        py_handle_group_peer_name(<Tox_Ptr> user_data, group_number, peer_id, name[:length])
    void py_handle_group_peer_status(self: Tox_Ptr, group_number: Tox_Group_Number, peer_id: Tox_Group_Peer_Number, status: Tox_User_Status) except *:
        self.handle_group_peer_status(group_number, peer_id, status)
    void handle_group_peer_status(Tox* tox, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id, Tox_User_Status status, void* user_data) except *:
        py_handle_group_peer_status(<Tox_Ptr> user_data, group_number, peer_id, Tox_User_Status(status))
    void py_handle_group_peer_limit(self: Tox_Ptr, group_number: Tox_Group_Number, peer_limit: int) except *:
        self.handle_group_peer_limit(group_number, peer_limit)
    void handle_group_peer_limit(Tox* tox, Tox_Group_Number group_number, uint32_t peer_limit, void* user_data) except *:
        py_handle_group_peer_limit(<Tox_Ptr> user_data, group_number, peer_limit)
    void py_handle_group_peer_join(self: Tox_Ptr, group_number: Tox_Group_Number, peer_id: Tox_Group_Peer_Number) except *:
        self.handle_group_peer_join(group_number, peer_id)
    void handle_group_peer_join(Tox* tox, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id, void* user_data) except *:
        py_handle_group_peer_join(<Tox_Ptr> user_data, group_number, peer_id)
    void py_handle_group_peer_exit(self: Tox_Ptr, group_number: Tox_Group_Number, peer_id: Tox_Group_Peer_Number, exit_type: Tox_Group_Exit_Type, name: bytes, part_message: bytes) except *:
        self.handle_group_peer_exit(group_number, peer_id, exit_type, name, part_message)
    void handle_group_peer_exit(Tox* tox, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id, Tox_Group_Exit_Type exit_type, const uint8_t* name, size_t name_length, const uint8_t* part_message, size_t part_message_length, void* user_data) except *:
        py_handle_group_peer_exit(<Tox_Ptr> user_data, group_number, peer_id, exit_type, name[:name_length], part_message[:part_message_length])
    void py_handle_group_topic(self: Tox_Ptr, group_number: Tox_Group_Number, peer_id: Tox_Group_Peer_Number, topic: bytes) except *:
        self.handle_group_topic(group_number, peer_id, topic)
    void handle_group_topic(Tox* tox, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id, const uint8_t* topic, size_t length, void* user_data) except *:
        py_handle_group_topic(<Tox_Ptr> user_data, group_number, peer_id, topic[:length])
    void py_handle_group_privacy_state(self: Tox_Ptr, group_number: Tox_Group_Number, privacy_state: Tox_Group_Privacy_State) except *:
        self.handle_group_privacy_state(group_number, privacy_state)
    void handle_group_privacy_state(Tox* tox, Tox_Group_Number group_number, Tox_Group_Privacy_State privacy_state, void* user_data) except *:
        py_handle_group_privacy_state(<Tox_Ptr> user_data, group_number, Tox_Group_Privacy_State(privacy_state))
    void py_handle_group_voice_state(self: Tox_Ptr, group_number: Tox_Group_Number, voice_state: Tox_Group_Voice_State) except *:
        self.handle_group_voice_state(group_number, voice_state)
    void handle_group_voice_state(Tox* tox, Tox_Group_Number group_number, Tox_Group_Voice_State voice_state, void* user_data) except *:
        py_handle_group_voice_state(<Tox_Ptr> user_data, group_number, Tox_Group_Voice_State(voice_state))
    void py_handle_group_topic_lock(self: Tox_Ptr, group_number: Tox_Group_Number, topic_lock: Tox_Group_Topic_Lock) except *:
        self.handle_group_topic_lock(group_number, topic_lock)
    void handle_group_topic_lock(Tox* tox, Tox_Group_Number group_number, Tox_Group_Topic_Lock topic_lock, void* user_data) except *:
        py_handle_group_topic_lock(<Tox_Ptr> user_data, group_number, Tox_Group_Topic_Lock(topic_lock))
    void py_handle_group_password(self: Tox_Ptr, group_number: Tox_Group_Number, password: bytes) except *:
        self.handle_group_password(group_number, password)
    void handle_group_password(Tox* tox, Tox_Group_Number group_number, const uint8_t* password, size_t length, void* user_data) except *:
        py_handle_group_password(<Tox_Ptr> user_data, group_number, password[:length])
    void py_handle_group_message(self: Tox_Ptr, group_number: Tox_Group_Number, peer_id: Tox_Group_Peer_Number, type_: Tox_Message_Type, message: bytes, message_id: Tox_Group_Message_Id) except *:
        self.handle_group_message(group_number, peer_id, type_, message, message_id)
    void handle_group_message(Tox* tox, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id, Tox_Message_Type type_, const uint8_t* message, size_t length, Tox_Group_Message_Id message_id, void* user_data) except *:
        py_handle_group_message(<Tox_Ptr> user_data, group_number, peer_id, Tox_Message_Type(type_), message[:length], message_id)
    void py_handle_group_private_message(self: Tox_Ptr, group_number: Tox_Group_Number, peer_id: Tox_Group_Peer_Number, type_: Tox_Message_Type, message: bytes) except *:
        self.handle_group_private_message(group_number, peer_id, type_, message)
    void handle_group_private_message(Tox* tox, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id, Tox_Message_Type type_, const uint8_t* message, size_t length, void* user_data) except *:
        py_handle_group_private_message(<Tox_Ptr> user_data, group_number, peer_id, Tox_Message_Type(type_), message[:length])
    void py_handle_group_custom_packet(self: Tox_Ptr, group_number: Tox_Group_Number, peer_id: Tox_Group_Peer_Number, data: bytes) except *:
        self.handle_group_custom_packet(group_number, peer_id, data)
    void handle_group_custom_packet(Tox* tox, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id, const uint8_t* data, size_t length, void* user_data) except *:
        py_handle_group_custom_packet(<Tox_Ptr> user_data, group_number, peer_id, data[:length])
    void py_handle_group_custom_private_packet(self: Tox_Ptr, group_number: Tox_Group_Number, peer_id: Tox_Group_Peer_Number, data: bytes) except *:
        self.handle_group_custom_private_packet(group_number, peer_id, data)
    void handle_group_custom_private_packet(Tox* tox, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id, const uint8_t* data, size_t length, void* user_data) except *:
        py_handle_group_custom_private_packet(<Tox_Ptr> user_data, group_number, peer_id, data[:length])
    void py_handle_group_invite(self: Tox_Ptr, friend_number: Tox_Friend_Number, invite_data: bytes, group_name: bytes) except *:
        self.handle_group_invite(friend_number, invite_data, group_name)
    void handle_group_invite(Tox* tox, Tox_Friend_Number friend_number, const uint8_t* invite_data, size_t length, const uint8_t* group_name, size_t group_name_length, void* user_data) except *:
        py_handle_group_invite(<Tox_Ptr> user_data, friend_number, invite_data[:length], group_name[:group_name_length])
    void py_handle_group_join_fail(self: Tox_Ptr, group_number: Tox_Group_Number, fail_type: Tox_Group_Join_Fail) except *:
        self.handle_group_join_fail(group_number, fail_type)
    void handle_group_join_fail(Tox* tox, Tox_Group_Number group_number, Tox_Group_Join_Fail fail_type, void* user_data) except *:
        py_handle_group_join_fail(<Tox_Ptr> user_data, group_number, Tox_Group_Join_Fail(fail_type))
    void py_handle_group_moderation(self: Tox_Ptr, group_number: Tox_Group_Number, source_peer_id: Tox_Group_Peer_Number, target_peer_id: Tox_Group_Peer_Number, mod_type: Tox_Group_Mod_Event) except *:
        self.handle_group_moderation(group_number, source_peer_id, target_peer_id, mod_type)
    void handle_group_moderation(Tox* tox, Tox_Group_Number group_number, Tox_Group_Peer_Number source_peer_id, Tox_Group_Peer_Number target_peer_id, Tox_Group_Mod_Event mod_type, void* user_data) except *:
        py_handle_group_moderation(<Tox_Ptr> user_data, group_number, source_peer_id, target_peer_id, mod_type)

    void install_handlers(Tox_Ptr self, Tox* ptr):
        tox_callback_self_connection_status(ptr, handle_self_connection_status)
        tox_callback_friend_name(ptr, handle_friend_name)
        tox_callback_friend_status_message(ptr, handle_friend_status_message)
        tox_callback_friend_status(ptr, handle_friend_status)
        tox_callback_friend_connection_status(ptr, handle_friend_connection_status)
        tox_callback_friend_typing(ptr, handle_friend_typing)
        tox_callback_friend_read_receipt(ptr, handle_friend_read_receipt)
        tox_callback_friend_request(ptr, handle_friend_request)
        tox_callback_friend_message(ptr, handle_friend_message)
        tox_callback_friend_lossy_packet(ptr, handle_friend_lossy_packet)
        tox_callback_friend_lossless_packet(ptr, handle_friend_lossless_packet)
        tox_callback_file_recv_control(ptr, handle_file_recv_control)
        tox_callback_file_chunk_request(ptr, handle_file_chunk_request)
        tox_callback_file_recv(ptr, handle_file_recv)
        tox_callback_file_recv_chunk(ptr, handle_file_recv_chunk)
        tox_callback_conference_peer_name(ptr, handle_conference_peer_name)
        tox_callback_conference_peer_list_changed(ptr, handle_conference_peer_list_changed)
        tox_callback_conference_invite(ptr, handle_conference_invite)
        tox_callback_conference_connected(ptr, handle_conference_connected)
        tox_callback_conference_message(ptr, handle_conference_message)
        tox_callback_conference_title(ptr, handle_conference_title)
        tox_callback_group_self_join(ptr, handle_group_self_join)
        tox_callback_group_peer_name(ptr, handle_group_peer_name)
        tox_callback_group_peer_status(ptr, handle_group_peer_status)
        tox_callback_group_peer_limit(ptr, handle_group_peer_limit)
        tox_callback_group_peer_join(ptr, handle_group_peer_join)
        tox_callback_group_peer_exit(ptr, handle_group_peer_exit)
        tox_callback_group_topic(ptr, handle_group_topic)
        tox_callback_group_privacy_state(ptr, handle_group_privacy_state)
        tox_callback_group_voice_state(ptr, handle_group_voice_state)
        tox_callback_group_topic_lock(ptr, handle_group_topic_lock)
        tox_callback_group_password(ptr, handle_group_password)
        tox_callback_group_message(ptr, handle_group_message)
        tox_callback_group_private_message(ptr, handle_group_private_message)
        tox_callback_group_custom_packet(ptr, handle_group_custom_packet)
        tox_callback_group_custom_private_packet(ptr, handle_group_custom_private_packet)
        tox_callback_group_invite(ptr, handle_group_invite)
        tox_callback_group_join_fail(ptr, handle_group_join_fail)
        tox_callback_group_moderation(ptr, handle_group_moderation)


cdef class Tox_Options_Ptr:
    cdef Tox_Options* _get(self) except *:
        if self._ptr is NULL:
            raise common.UseAfterFreeException()
        return self._ptr

    def __dealloc__(self):
        self.__exit__(None, None, None)

    def __enter__(self):
        return self

    @property
    def ipv6_enabled(self) -> bool:
        return tox_options_get_ipv6_enabled(self._get())

    @ipv6_enabled.setter
    def ipv6_enabled(self, ipv6_enabled: bool):
        tox_options_set_ipv6_enabled(self._get(), ipv6_enabled)

    @property
    def udp_enabled(self) -> bool:
        return tox_options_get_udp_enabled(self._get())

    @udp_enabled.setter
    def udp_enabled(self, udp_enabled: bool):
        tox_options_set_udp_enabled(self._get(), udp_enabled)

    @property
    def local_discovery_enabled(self) -> bool:
        return tox_options_get_local_discovery_enabled(self._get())

    @local_discovery_enabled.setter
    def local_discovery_enabled(self, local_discovery_enabled: bool):
        tox_options_set_local_discovery_enabled(self._get(), local_discovery_enabled)

    @property
    def dht_announcements_enabled(self) -> bool:
        return tox_options_get_dht_announcements_enabled(self._get())

    @dht_announcements_enabled.setter
    def dht_announcements_enabled(self, dht_announcements_enabled: bool):
        tox_options_set_dht_announcements_enabled(self._get(), dht_announcements_enabled)

    @property
    def proxy_type(self) -> Tox_Proxy_Type:
        return tox_options_get_proxy_type(self._get())

    @proxy_type.setter
    def proxy_type(self, proxy_type: Tox_Proxy_Type):
        tox_options_set_proxy_type(self._get(), proxy_type)

    @property
    def proxy_host(self) -> str:
        return str(tox_options_get_proxy_host(self._get()))

    @proxy_host.setter
    def proxy_host(self, proxy_host: str):
        tox_options_set_proxy_host(self._get(), proxy_host)

    @property
    def proxy_port(self) -> int:
        return tox_options_get_proxy_port(self._get())

    @proxy_port.setter
    def proxy_port(self, proxy_port: int):
        tox_options_set_proxy_port(self._get(), proxy_port)

    @property
    def start_port(self) -> int:
        return tox_options_get_start_port(self._get())

    @start_port.setter
    def start_port(self, start_port: int):
        tox_options_set_start_port(self._get(), start_port)

    @property
    def end_port(self) -> int:
        return tox_options_get_end_port(self._get())

    @end_port.setter
    def end_port(self, end_port: int):
        tox_options_set_end_port(self._get(), end_port)

    @property
    def tcp_port(self) -> int:
        return tox_options_get_tcp_port(self._get())

    @tcp_port.setter
    def tcp_port(self, tcp_port: int):
        tox_options_set_tcp_port(self._get(), tcp_port)

    @property
    def hole_punching_enabled(self) -> bool:
        return tox_options_get_hole_punching_enabled(self._get())

    @hole_punching_enabled.setter
    def hole_punching_enabled(self, hole_punching_enabled: bool):
        tox_options_set_hole_punching_enabled(self._get(), hole_punching_enabled)

    @property
    def savedata_type(self) -> Tox_Savedata_Type:
        return tox_options_get_savedata_type(self._get())

    @savedata_type.setter
    def savedata_type(self, savedata_type: Tox_Savedata_Type):
        tox_options_set_savedata_type(self._get(), savedata_type)

    @property
    def experimental_thread_safety(self) -> bool:
        return tox_options_get_experimental_thread_safety(self._get())

    @experimental_thread_safety.setter
    def experimental_thread_safety(self, experimental_thread_safety: bool):
        tox_options_set_experimental_thread_safety(self._get(), experimental_thread_safety)

    cdef Tox_Options* _new(self):
        cdef Tox_Err_Options_New error = TOX_ERR_OPTIONS_NEW_OK
        cdef Tox_Options* ptr = tox_options_new(&error)
        if error: raise ApiException(Tox_Err_Options_New(error))
        return ptr

    def __init__(self):
        self._ptr = self._new()

    def __exit__(self, exc_type, exc_value, exc_traceback):
        tox_options_free(self._ptr)
        self._ptr = NULL


cdef class Tox_Ptr:
    cdef Tox* _get(self) except *:
        if self._ptr is NULL:
            raise common.UseAfterFreeException()
        return self._ptr

    def __dealloc__(self):
        self.__exit__(None, None, None)

    def __enter__(self):
        return self

    cdef Tox* _new(self, Tox_Options_Ptr options):
        cdef Tox_Err_New error = TOX_ERR_NEW_OK
        cdef Tox* ptr = tox_new(options._get() if options else NULL, &error)
        if error: raise ApiException(Tox_Err_New(error))
        return ptr

    def __init__(self, Tox_Options_Ptr options):
        self._ptr = self._new(options)
        install_handlers(self, self._ptr)

    def __exit__(self, exc_type, exc_value, exc_traceback):
        tox_kill(self._ptr)
        self._ptr = NULL

    @property
    def connection_status(self) -> Tox_Connection:
        return Tox_Connection(tox_self_get_connection_status(self._get()))

    @property
    def nospam(self) -> int:
        return tox_self_get_nospam(self._get())

    @nospam.setter
    def nospam(self, nospam: int):
        tox_self_set_nospam(self._get(), nospam)

    @property
    def status(self) -> Tox_User_Status:
        return Tox_User_Status(tox_self_get_status(self._get()))

    @status.setter
    def status(self, status: Tox_User_Status):
        tox_self_set_status(self._get(), status)

    @property
    def group_number_groups(self) -> int:
        return tox_group_get_number_groups(self._get())

    ############################################################
    ########################## Manual ##########################
    ############################################################

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
        common._check_len("public_key", public_key, tox_public_key_size())
        cdef Tox_Err_Bootstrap err = TOX_ERR_BOOTSTRAP_OK
        return tox_bootstrap(self._get(), host.encode("utf-8"), port, public_key, &err)

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

    def friend_add(self, address: bytes, message: bytes):
        common._check_len("address", address, tox_address_size())
        cdef Tox_Err_Friend_Add err = TOX_ERR_FRIEND_ADD_OK
        tox_friend_add(self._get(), address, message, len(message), &err)
        if err: raise ApiException(Tox_Err_Friend_Add(err))

    def friend_add_norequest(self, public_key: bytes):
        common._check_len("public_key", public_key, tox_public_key_size())
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

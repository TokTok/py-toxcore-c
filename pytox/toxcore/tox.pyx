# cython: language_level=3, linetrace=True
from array import array
from pytox import common
from types import TracebackType
from typing import Optional
from typing import TypeVar

T = TypeVar("T")

class ApiException(common.ApiException):
    pass


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
    void handle_group_peer_name(Tox* tox, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id, const uint8_t* name, size_t name_length, void* user_data) except *:
        py_handle_group_peer_name(<Tox_Ptr> user_data, group_number, peer_id, name[:name_length])
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
    void handle_group_topic(Tox* tox, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id, const uint8_t* topic, size_t topic_length, void* user_data) except *:
        py_handle_group_topic(<Tox_Ptr> user_data, group_number, peer_id, topic[:topic_length])
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
    void handle_group_password(Tox* tox, Tox_Group_Number group_number, const uint8_t* password, size_t password_length, void* user_data) except *:
        py_handle_group_password(<Tox_Ptr> user_data, group_number, password[:password_length])
    void py_handle_group_message(self: Tox_Ptr, group_number: Tox_Group_Number, peer_id: Tox_Group_Peer_Number, message_type: Tox_Message_Type, message: bytes, message_id: Tox_Group_Message_Id) except *:
        self.handle_group_message(group_number, peer_id, message_type, message, message_id)
    void handle_group_message(Tox* tox, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id, Tox_Message_Type message_type, const uint8_t* message, size_t message_length, Tox_Group_Message_Id message_id, void* user_data) except *:
        py_handle_group_message(<Tox_Ptr> user_data, group_number, peer_id, Tox_Message_Type(message_type), message[:message_length], message_id)
    void py_handle_group_private_message(self: Tox_Ptr, group_number: Tox_Group_Number, peer_id: Tox_Group_Peer_Number, message_type: Tox_Message_Type, message: bytes, message_id: Tox_Group_Message_Id) except *:
        self.handle_group_private_message(group_number, peer_id, message_type, message, message_id)
    void handle_group_private_message(Tox* tox, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id, Tox_Message_Type message_type, const uint8_t* message, size_t message_length, Tox_Group_Message_Id message_id, void* user_data) except *:
        py_handle_group_private_message(<Tox_Ptr> user_data, group_number, peer_id, Tox_Message_Type(message_type), message[:message_length], message_id)
    void py_handle_group_custom_packet(self: Tox_Ptr, group_number: Tox_Group_Number, peer_id: Tox_Group_Peer_Number, data: bytes) except *:
        self.handle_group_custom_packet(group_number, peer_id, data)
    void handle_group_custom_packet(Tox* tox, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id, const uint8_t* data, size_t data_length, void* user_data) except *:
        py_handle_group_custom_packet(<Tox_Ptr> user_data, group_number, peer_id, data[:data_length])
    void py_handle_group_custom_private_packet(self: Tox_Ptr, group_number: Tox_Group_Number, peer_id: Tox_Group_Peer_Number, data: bytes) except *:
        self.handle_group_custom_private_packet(group_number, peer_id, data)
    void handle_group_custom_private_packet(Tox* tox, Tox_Group_Number group_number, Tox_Group_Peer_Number peer_id, const uint8_t* data, size_t data_length, void* user_data) except *:
        py_handle_group_custom_private_packet(<Tox_Ptr> user_data, group_number, peer_id, data[:data_length])
    void py_handle_group_invite(self: Tox_Ptr, friend_number: Tox_Friend_Number, invite_data: bytes, group_name: bytes) except *:
        self.handle_group_invite(friend_number, invite_data, group_name)
    void handle_group_invite(Tox* tox, Tox_Friend_Number friend_number, const uint8_t* invite_data, size_t invite_data_length, const uint8_t* group_name, size_t group_name_length, void* user_data) except *:
        py_handle_group_invite(<Tox_Ptr> user_data, friend_number, invite_data[:invite_data_length], group_name[:group_name_length])
    void py_handle_group_join_fail(self: Tox_Ptr, group_number: Tox_Group_Number, fail_type: Tox_Group_Join_Fail) except *:
        self.handle_group_join_fail(group_number, fail_type)
    void handle_group_join_fail(Tox* tox, Tox_Group_Number group_number, Tox_Group_Join_Fail fail_type, void* user_data) except *:
        py_handle_group_join_fail(<Tox_Ptr> user_data, group_number, Tox_Group_Join_Fail(fail_type))
    void py_handle_group_moderation(self: Tox_Ptr, group_number: Tox_Group_Number, source_peer_id: Tox_Group_Peer_Number, target_peer_id: Tox_Group_Peer_Number, mod_type: Tox_Group_Mod_Event) except *:
        self.handle_group_moderation(group_number, source_peer_id, target_peer_id, mod_type)
    void handle_group_moderation(Tox* tox, Tox_Group_Number group_number, Tox_Group_Peer_Number source_peer_id, Tox_Group_Peer_Number target_peer_id, Tox_Group_Mod_Event mod_type, void* user_data) except *:
        py_handle_group_moderation(<Tox_Ptr> user_data, group_number, source_peer_id, target_peer_id, Tox_Group_Mod_Event(mod_type))

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

    def __del__(self) -> None:
        self.__exit__(None, None, None)

    def __enter__(self: T) -> T:
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
        return tox_options_get_proxy_host(self._get()).decode("utf-8")

    @proxy_host.setter
    def proxy_host(self, proxy_host: str):
        tox_options_set_proxy_host(self._get(), proxy_host.encode("utf-8"))

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
    def savedata_data(self) -> bytes:
        return tox_options_get_savedata_data(self._get())[:tox_options_get_savedata_length(self._get())]

    @savedata_data.setter
    def savedata_data(self, savedata_data: bytes):
        tox_options_set_savedata_data(self._get(), savedata_data, len(savedata_data))

    @property
    def experimental_owned_data(self) -> bool:
        return tox_options_get_experimental_owned_data(self._get())

    @experimental_owned_data.setter
    def experimental_owned_data(self, experimental_owned_data: bool):
        tox_options_set_experimental_owned_data(self._get(), experimental_owned_data)

    @property
    def experimental_thread_safety(self) -> bool:
        return tox_options_get_experimental_thread_safety(self._get())

    @experimental_thread_safety.setter
    def experimental_thread_safety(self, experimental_thread_safety: bool):
        tox_options_set_experimental_thread_safety(self._get(), experimental_thread_safety)

    @property
    def experimental_groups_persistence(self) -> bool:
        return tox_options_get_experimental_groups_persistence(self._get())

    @experimental_groups_persistence.setter
    def experimental_groups_persistence(self, experimental_groups_persistence: bool):
        tox_options_set_experimental_groups_persistence(self._get(), experimental_groups_persistence)

    @property
    def experimental_disable_dns(self) -> bool:
        return tox_options_get_experimental_disable_dns(self._get())

    @experimental_disable_dns.setter
    def experimental_disable_dns(self, experimental_disable_dns: bool):
        tox_options_set_experimental_disable_dns(self._get(), experimental_disable_dns)

    cdef Tox_Options* _new(self):
        cdef Tox_Err_Options_New error = TOX_ERR_OPTIONS_NEW_OK
        cdef Tox_Options* ptr = tox_options_new(&error)
        if error:
            raise ApiException(Tox_Err_Options_New(error))
        return ptr

    def __exit__(self, exc_type: type[BaseException] | None, exc_value: BaseException | None, exc_traceback: TracebackType | None) -> None:
        tox_options_free(self._ptr)
        self._ptr = NULL

    def __init__(self):
        """Create new Tox_Options object."""
        self._ptr = self._new()


cdef class Tox_Ptr:
    cdef Tox* _get(self) except *:
        if self._ptr is NULL:
            raise common.UseAfterFreeException()
        return self._ptr

    def __del__(self) -> None:
        self.__exit__(None, None, None)

    def __enter__(self: T) -> T:
        return self

    cdef Tox* _new(self, Tox_Options_Ptr options):
        cdef Tox_Err_New error = TOX_ERR_NEW_OK
        cdef Tox* ptr = tox_new(options._get() if options else NULL, &error)
        if error:
            raise ApiException(Tox_Err_New(error))
        return ptr

    def __exit__(self, exc_type: type[BaseException] | None, exc_value: BaseException | None, exc_traceback: TracebackType | None) -> None:
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
        tox_self_set_status(self._get(), Tox_User_Status(status))

    @property
    def group_number_groups(self) -> int:
        return tox_group_get_number_groups(self._get())

    def handle_self_connection_status(self, connection_status: Tox_Connection) -> None: pass
    def handle_friend_name(self, friend_number: Tox_Friend_Number, name: bytes) -> None: pass
    def handle_friend_status_message(self, friend_number: Tox_Friend_Number, message: bytes) -> None: pass
    def handle_friend_status(self, friend_number: Tox_Friend_Number, status: Tox_User_Status) -> None: pass
    def handle_friend_connection_status(self, friend_number: Tox_Friend_Number, connection_status: Tox_Connection) -> None: pass
    def handle_friend_typing(self, friend_number: Tox_Friend_Number, typing: bool) -> None: pass
    def handle_friend_read_receipt(self, friend_number: Tox_Friend_Number, message_id: Tox_Friend_Message_Id) -> None: pass
    def handle_friend_request(self, public_key: bytes, message: bytes) -> None: pass
    def handle_friend_message(self, friend_number: Tox_Friend_Number, type_: Tox_Message_Type, message: bytes) -> None: pass
    def handle_friend_lossy_packet(self, friend_number: Tox_Friend_Number, data: bytes) -> None: pass
    def handle_friend_lossless_packet(self, friend_number: Tox_Friend_Number, data: bytes) -> None: pass
    def handle_file_recv_control(self, friend_number: Tox_Friend_Number, file_number: Tox_File_Number, control: Tox_File_Control) -> None: pass
    def handle_file_chunk_request(self, friend_number: Tox_Friend_Number, file_number: Tox_File_Number, position: int, length: int) -> None: pass
    def handle_file_recv(self, friend_number: Tox_Friend_Number, file_number: Tox_File_Number, kind: int, file_size: int, filename: bytes) -> None: pass
    def handle_file_recv_chunk(self, friend_number: Tox_Friend_Number, file_number: Tox_File_Number, position: int, data: bytes) -> None: pass
    def handle_conference_peer_name(self, conference_number: Tox_Conference_Number, peer_number: Tox_Conference_Peer_Number, name: bytes) -> None: pass
    def handle_conference_peer_list_changed(self, conference_number: Tox_Conference_Number) -> None: pass
    def handle_conference_invite(self, friend_number: Tox_Friend_Number, type_: Tox_Conference_Type, cookie: bytes) -> None: pass
    def handle_conference_connected(self, conference_number: Tox_Conference_Number) -> None: pass
    def handle_conference_message(self, conference_number: Tox_Conference_Number, peer_number: Tox_Conference_Peer_Number, type_: Tox_Message_Type, message: bytes) -> None: pass
    def handle_conference_title(self, conference_number: Tox_Conference_Number, peer_number: Tox_Conference_Peer_Number, title: bytes) -> None: pass
    def handle_group_self_join(self, group_number: Tox_Group_Number) -> None: pass
    def handle_group_peer_name(self, group_number: Tox_Group_Number, peer_id: Tox_Group_Peer_Number, name: bytes) -> None: pass
    def handle_group_peer_status(self, group_number: Tox_Group_Number, peer_id: Tox_Group_Peer_Number, status: Tox_User_Status) -> None: pass
    def handle_group_peer_limit(self, group_number: Tox_Group_Number, peer_limit: int) -> None: pass
    def handle_group_peer_join(self, group_number: Tox_Group_Number, peer_id: Tox_Group_Peer_Number) -> None: pass
    def handle_group_peer_exit(self, group_number: Tox_Group_Number, peer_id: Tox_Group_Peer_Number, exit_type: Tox_Group_Exit_Type, name: bytes, part_message: bytes) -> None: pass
    def handle_group_topic(self, group_number: Tox_Group_Number, peer_id: Tox_Group_Peer_Number, topic: bytes) -> None: pass
    def handle_group_privacy_state(self, group_number: Tox_Group_Number, privacy_state: Tox_Group_Privacy_State) -> None: pass
    def handle_group_voice_state(self, group_number: Tox_Group_Number, voice_state: Tox_Group_Voice_State) -> None: pass
    def handle_group_topic_lock(self, group_number: Tox_Group_Number, topic_lock: Tox_Group_Topic_Lock) -> None: pass
    def handle_group_password(self, group_number: Tox_Group_Number, password: bytes) -> None: pass
    def handle_group_message(self, group_number: Tox_Group_Number, peer_id: Tox_Group_Peer_Number, message_type: Tox_Message_Type, message: bytes, message_id: Tox_Group_Message_Id) -> None: pass
    def handle_group_private_message(self, group_number: Tox_Group_Number, peer_id: Tox_Group_Peer_Number, message_type: Tox_Message_Type, message: bytes, message_id: Tox_Group_Message_Id) -> None: pass
    def handle_group_custom_packet(self, group_number: Tox_Group_Number, peer_id: Tox_Group_Peer_Number, data: bytes) -> None: pass
    def handle_group_custom_private_packet(self, group_number: Tox_Group_Number, peer_id: Tox_Group_Peer_Number, data: bytes) -> None: pass
    def handle_group_invite(self, friend_number: Tox_Friend_Number, invite_data: bytes, group_name: bytes) -> None: pass
    def handle_group_join_fail(self, group_number: Tox_Group_Number, fail_type: Tox_Group_Join_Fail) -> None: pass
    def handle_group_moderation(self, group_number: Tox_Group_Number, source_peer_id: Tox_Group_Peer_Number, target_peer_id: Tox_Group_Peer_Number, mod_type: Tox_Group_Mod_Event) -> None: pass

    #
    # Manual
    #

    def __init__(self, options: Optional[Tox_Options_Ptr] = None):
        """Create new Tox object."""
        self._ptr = self._new(options)
        install_handlers(self, self._ptr)

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
        common.check_len("public_key", public_key, tox_public_key_size())
        cdef Tox_Err_Bootstrap err = TOX_ERR_BOOTSTRAP_OK
        cdef bool res = tox_bootstrap(self._get(), host.encode("utf-8"), port, public_key, &err)
        if err:
            raise ApiException(Tox_Err_Bootstrap(err))
        return res

    def add_tcp_relay(self, host: str, port: int, public_key: bytes) -> bool:
        common.check_len("public_key", public_key, tox_public_key_size())
        cdef Tox_Err_Bootstrap err = TOX_ERR_BOOTSTRAP_OK
        cdef bool res = tox_add_tcp_relay(self._get(), host.encode("utf-8"), port, public_key, &err)
        if err:
            raise ApiException(Tox_Err_Bootstrap(err))
        return res

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
    def dht_id(self) -> bytes:
        cdef size_t size = tox_public_key_size()
        cdef uint8_t *data = <uint8_t*> malloc(size * sizeof(uint8_t))
        try:
            tox_self_get_dht_id(self._get(), data)
            return data[:tox_public_key_size()]
        finally:
            free(data)

    @property
    def udp_port(self) -> int:
        cdef Tox_Err_Get_Port err = TOX_ERR_GET_PORT_OK
        cdef uint16_t res = tox_self_get_udp_port(self._get(), &err)
        if err:
            raise ApiException(Tox_Err_Get_Port(err))
        return res

    @property
    def tcp_port(self) -> int:
        cdef Tox_Err_Get_Port err = TOX_ERR_GET_PORT_OK
        cdef uint16_t res = tox_self_get_tcp_port(self._get(), &err)
        if err:
            raise ApiException(Tox_Err_Get_Port(err))
        return res

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
        if err:
            raise ApiException(Tox_Err_Set_Info(err))

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
        if err:
            raise ApiException(Tox_Err_Set_Info(err))

    def friend_add(self, address: bytes, message: bytes) -> Tox_Friend_Number:
        common.check_len("address", address, tox_address_size())
        cdef Tox_Err_Friend_Add err = TOX_ERR_FRIEND_ADD_OK
        cdef Tox_Friend_Number res = tox_friend_add(self._get(), address, message, len(message), &err)
        if err:
            raise ApiException(Tox_Err_Friend_Add(err))
        return res

    def friend_add_norequest(self, public_key: bytes) -> Tox_Friend_Number:
        common.check_len("public_key", public_key, tox_public_key_size())
        cdef Tox_Err_Friend_Add err = TOX_ERR_FRIEND_ADD_OK
        cdef Tox_Friend_Number res = tox_friend_add_norequest(self._get(), public_key, &err)
        if err:
            raise ApiException(Tox_Err_Friend_Add(err))
        return res

    def friend_delete(self, friend_number: Tox_Friend_Number):
        cdef Tox_Err_Friend_Delete err = TOX_ERR_FRIEND_DELETE_OK
        tox_friend_delete(self._get(), friend_number, &err)
        if err:
            raise ApiException(Tox_Err_Friend_Delete(err))

    def friend_by_public_key(self, public_key: bytes) -> Tox_Friend_Number:
        common.check_len("public_key", public_key, tox_public_key_size())
        cdef Tox_Err_Friend_By_Public_Key err = TOX_ERR_FRIEND_BY_PUBLIC_KEY_OK
        cdef Tox_Friend_Number res = tox_friend_by_public_key(self._get(), public_key, &err)
        if err:
            raise ApiException(Tox_Err_Friend_By_Public_Key(err))
        return res

    def friend_exists(self, friend_number: Tox_Friend_Number) -> bool:
        return tox_friend_exists(self._get(), friend_number)

    @property
    def friend_list(self) -> list[Tox_Friend_Number]:
        cdef size_t size = tox_self_get_friend_list_size(self._get())
        cdef Tox_Friend_Number *data = <Tox_Friend_Number*> malloc(size * sizeof(Tox_Friend_Number))
        try:
            tox_self_get_friend_list(self._get(), data)
            return [data[i] for i in range(size)]
        finally:
            free(data)

    def friend_get_public_key(self, friend_number: Tox_Friend_Number) -> bytes:
        cdef size_t size = tox_public_key_size()
        cdef uint8_t *data = <uint8_t*> malloc(size * sizeof(uint8_t))
        cdef Tox_Err_Friend_Get_Public_Key err = TOX_ERR_FRIEND_GET_PUBLIC_KEY_OK
        try:
            tox_friend_get_public_key(self._get(), friend_number, data, &err)
            if err:
                raise ApiException(Tox_Err_Friend_Get_Public_Key(err))
            return data[:size]
        finally:
            free(data)

    def friend_get_status(self, friend_number: Tox_Friend_Number) -> Tox_User_Status:
        cdef Tox_Err_Friend_Query err = TOX_ERR_FRIEND_QUERY_OK
        cdef Tox_User_Status res = tox_friend_get_status(self._get(), friend_number, &err)
        if err:
            raise ApiException(Tox_Err_Friend_Query(err))
        return Tox_User_Status(res)

    def friend_get_status_message(self, friend_number: Tox_Friend_Number) -> bytes:
        cdef Tox_Err_Friend_Query err = TOX_ERR_FRIEND_QUERY_OK
        cdef size_t size = tox_friend_get_status_message_size(self._get(), friend_number, &err)
        if err:
            raise ApiException(Tox_Err_Friend_Query(err))
        cdef uint8_t *data = <uint8_t*> malloc(size * sizeof(uint8_t))
        try:
            tox_friend_get_status_message(self._get(), friend_number, data, &err)
            if err:
                raise ApiException(Tox_Err_Friend_Query(err))
            return data[:size]
        finally:
            free(data)

    def friend_get_name(self, friend_number: Tox_Friend_Number) -> bytes:
        cdef Tox_Err_Friend_Query err = TOX_ERR_FRIEND_QUERY_OK
        cdef size_t size = tox_friend_get_name_size(self._get(), friend_number, &err)
        if err:
            raise ApiException(Tox_Err_Friend_Query(err))
        cdef uint8_t *data = <uint8_t*> malloc(size * sizeof(uint8_t))
        try:
            tox_friend_get_name(self._get(), friend_number, data, &err)
            if err:
                raise ApiException(Tox_Err_Friend_Query(err))
            return data[:size]
        finally:
            free(data)

    def friend_get_connection_status(self, friend_number: Tox_Friend_Number) -> Tox_Connection:
        cdef Tox_Err_Friend_Query err = TOX_ERR_FRIEND_QUERY_OK
        cdef Tox_Connection res = tox_friend_get_connection_status(self._get(), friend_number, &err)
        if err:
            raise ApiException(Tox_Err_Friend_Query(err))
        return Tox_Connection(res)

    def friend_get_last_online(self, friend_number: Tox_Friend_Number) -> int:
        cdef Tox_Err_Friend_Get_Last_Online err = TOX_ERR_FRIEND_GET_LAST_ONLINE_OK
        cdef int64_t res = tox_friend_get_last_online(self._get(), friend_number, &err)
        if err:
            raise ApiException(Tox_Err_Friend_Get_Last_Online(err))
        return res

    def friend_get_typing(self, friend_number: Tox_Friend_Number) -> bool:
        cdef Tox_Err_Friend_Query err = TOX_ERR_FRIEND_QUERY_OK
        cdef bool res = tox_friend_get_typing(self._get(), friend_number, &err)
        if err:
            raise ApiException(Tox_Err_Friend_Query(err))
        return res

    def set_typing(self, friend_number: Tox_Friend_Number, typing: bool) -> None:
        cdef Tox_Err_Set_Typing err = TOX_ERR_SET_TYPING_OK
        tox_self_set_typing(self._get(), friend_number, typing, &err)
        if err:
            raise ApiException(Tox_Err_Set_Typing(err))

    def friend_send_message(self, friend_number: Tox_Friend_Number, type_: Tox_Message_Type, message: bytes) -> Tox_Friend_Message_Id:
        cdef Tox_Err_Friend_Send_Message err = TOX_ERR_FRIEND_SEND_MESSAGE_OK
        cdef Tox_Friend_Message_Id res = tox_friend_send_message(self._get(), friend_number, type_, message, len(message), &err)
        if err:
            raise ApiException(Tox_Err_Friend_Send_Message(err))
        return res

    def friend_send_lossy_packet(self, friend_number: Tox_Friend_Number, data: bytes) -> None:
        cdef Tox_Err_Friend_Custom_Packet err = TOX_ERR_FRIEND_CUSTOM_PACKET_OK
        tox_friend_send_lossy_packet(self._get(), friend_number, data, len(data), &err)
        if err:
            raise ApiException(Tox_Err_Friend_Custom_Packet(err))

    def friend_send_lossless_packet(self, friend_number: Tox_Friend_Number, data: bytes) -> None:
        cdef Tox_Err_Friend_Custom_Packet err = TOX_ERR_FRIEND_CUSTOM_PACKET_OK
        tox_friend_send_lossless_packet(self._get(), friend_number, data, len(data), &err)
        if err:
            raise ApiException(Tox_Err_Friend_Custom_Packet(err))

    def file_get_file_id(self, friend_number: Tox_Friend_Number, file_number: Tox_File_Number) -> bytes:
        cdef Tox_Err_File_Get err = TOX_ERR_FILE_GET_OK
        cdef size_t size = tox_file_id_length()
        cdef uint8_t *data = <uint8_t*> malloc(size * sizeof(uint8_t))
        try:
            tox_file_get_file_id(self._get(), friend_number, file_number, data, &err)
            if err:
                raise ApiException(Tox_Err_File_Get(err))
            return data[:size]
        finally:
            free(data)

    def file_control(self, friend_number: Tox_Friend_Number, file_number: Tox_File_Number, control: Tox_File_Control) -> None:
        cdef Tox_Err_File_Control err = TOX_ERR_FILE_CONTROL_OK
        tox_file_control(self._get(), friend_number, file_number, control, &err)
        if err:
            raise ApiException(Tox_Err_File_Control(err))

    def file_seek(self, friend_number: Tox_Friend_Number, file_number: Tox_File_Number, position: int) -> None:
        cdef Tox_Err_File_Seek err = TOX_ERR_FILE_SEEK_OK
        tox_file_seek(self._get(), friend_number, file_number, position, &err)
        if err:
            raise ApiException(Tox_Err_File_Seek(err))

    def file_send(self, friend_number: Tox_Friend_Number, kind: int, file_size: int, file_id: bytes, filename: bytes) -> Tox_File_Number:
        common.check_len("file_id", file_id, tox_file_id_length())
        cdef Tox_Err_File_Send err = TOX_ERR_FILE_SEND_OK
        cdef Tox_File_Number res = tox_file_send(self._get(), friend_number, kind, file_size, file_id, filename, len(filename), &err)
        if err:
            raise ApiException(Tox_Err_File_Send(err))
        return res

    def file_send_chunk(self, friend_number: Tox_Friend_Number, file_number: Tox_File_Number, position: int, data: bytes) -> None:
        cdef Tox_Err_File_Send_Chunk err = TOX_ERR_FILE_SEND_CHUNK_OK
        tox_file_send_chunk(self._get(), friend_number, file_number, position, data, len(data), &err)
        if err:
            raise ApiException(Tox_Err_File_Send_Chunk(err))

    def conference_new(self) -> Tox_Conference_Number:
        cdef Tox_Err_Conference_New err = TOX_ERR_CONFERENCE_NEW_OK
        cdef Tox_Conference_Number res = tox_conference_new(self._get(), &err)
        if err:
            raise ApiException(Tox_Err_Conference_New(err))
        return res

    def conference_delete(self, conference_number: Tox_Conference_Number) -> None:
        cdef Tox_Err_Conference_Delete err = TOX_ERR_CONFERENCE_DELETE_OK
        tox_conference_delete(self._get(), conference_number, &err)
        if err:
            raise ApiException(Tox_Err_Conference_Delete(err))

    def conference_invite(self, friend_number: Tox_Friend_Number, conference_number: Tox_Conference_Number) -> None:
        cdef Tox_Err_Conference_Invite err = TOX_ERR_CONFERENCE_INVITE_OK
        tox_conference_invite(self._get(), friend_number, conference_number, &err)
        if err:
            raise ApiException(Tox_Err_Conference_Invite(err))

    def conference_join(self, friend_number: Tox_Friend_Number, cookie: bytes) -> Tox_Conference_Number:
        cdef Tox_Err_Conference_Join err = TOX_ERR_CONFERENCE_JOIN_OK
        cdef Tox_Conference_Number res = tox_conference_join(self._get(), friend_number, cookie, len(cookie), &err)
        if err:
            raise ApiException(Tox_Err_Conference_Join(err))
        return res

    def conference_send_message(self, conference_number: Tox_Conference_Number, type_: Tox_Message_Type, message: bytes) -> None:
        cdef Tox_Err_Conference_Send_Message err = TOX_ERR_CONFERENCE_SEND_MESSAGE_OK
        tox_conference_send_message(self._get(), conference_number, type_, message, len(message), &err)
        if err:
            raise ApiException(Tox_Err_Conference_Send_Message(err))

    def conference_get_title(self, conference_number: Tox_Conference_Number) -> bytes:
        cdef Tox_Err_Conference_Title err = TOX_ERR_CONFERENCE_TITLE_OK
        cdef size_t size = tox_conference_get_title_size(self._get(), conference_number, &err)
        if err:
            raise ApiException(Tox_Err_Conference_Title(err))
        cdef uint8_t *data = <uint8_t*> malloc(size * sizeof(uint8_t))
        try:
            tox_conference_get_title(self._get(), conference_number, data, &err)
            if err:
                raise ApiException(Tox_Err_Conference_Title(err))
            return data[:size]
        finally:
            free(data)

    def conference_set_title(self, conference_number: Tox_Conference_Number, title: bytes) -> None:
        cdef Tox_Err_Conference_Title err = TOX_ERR_CONFERENCE_TITLE_OK
        tox_conference_set_title(self._get(), conference_number, title, len(title), &err)
        if err:
            raise ApiException(Tox_Err_Conference_Title(err))

    def conference_get_peer_count(self, conference_number: Tox_Conference_Number) -> int:
        cdef Tox_Err_Conference_Peer_Query err = TOX_ERR_CONFERENCE_PEER_QUERY_OK
        cdef uint32_t count = tox_conference_peer_count(self._get(), conference_number, &err)
        if err:
            raise ApiException(Tox_Err_Conference_Peer_Query(err))
        return count

    def conference_get_offline_peer_count(self, conference_number: Tox_Conference_Number) -> int:
        cdef Tox_Err_Conference_Peer_Query err = TOX_ERR_CONFERENCE_PEER_QUERY_OK
        cdef uint32_t count = tox_conference_offline_peer_count(self._get(), conference_number, &err)
        if err:
            raise ApiException(Tox_Err_Conference_Peer_Query(err))
        return count

    def conference_set_max_offline_peers(self, conference_number: Tox_Conference_Number, max_offline: int) -> None:
        cdef Tox_Err_Conference_Set_Max_Offline err = TOX_ERR_CONFERENCE_SET_MAX_OFFLINE_OK
        tox_conference_set_max_offline(self._get(), conference_number, max_offline, &err)
        if err:
            raise ApiException(Tox_Err_Conference_Set_Max_Offline(err))

    def conference_get_peer_name(self, conference_number: Tox_Conference_Number, peer_number: Tox_Conference_Peer_Number) -> bytes:
        cdef Tox_Err_Conference_Peer_Query err = TOX_ERR_CONFERENCE_PEER_QUERY_OK
        cdef size_t size = tox_conference_peer_get_name_size(self._get(), conference_number, peer_number, &err)
        if err:
            raise ApiException(Tox_Err_Conference_Peer_Query(err))
        cdef uint8_t *data = <uint8_t*> malloc(size * sizeof(uint8_t))
        try:
            tox_conference_peer_get_name(self._get(), conference_number, peer_number, data, &err)
            if err:
                raise ApiException(Tox_Err_Conference_Peer_Query(err))
            return data[:size]
        finally:
            free(data)

    def conference_offline_peer_get_name(self, conference_number: Tox_Conference_Number, offline_peer_number: Tox_Conference_Offline_Peer_Number) -> bytes:
        cdef Tox_Err_Conference_Peer_Query err = TOX_ERR_CONFERENCE_PEER_QUERY_OK
        cdef size_t size = tox_conference_offline_peer_get_name_size(self._get(), conference_number, offline_peer_number, &err)
        if err:
            raise ApiException(Tox_Err_Conference_Peer_Query(err))
        cdef uint8_t *data = <uint8_t*> malloc(size * sizeof(uint8_t))
        try:
            tox_conference_offline_peer_get_name(self._get(), conference_number, offline_peer_number, data, &err)
            if err:
                raise ApiException(Tox_Err_Conference_Peer_Query(err))
            return data[:size]
        finally:
            free(data)

    def conference_peer_get_public_key(self, conference_number: Tox_Conference_Number, peer_number: Tox_Conference_Peer_Number) -> bytes:
        cdef Tox_Err_Conference_Peer_Query err = TOX_ERR_CONFERENCE_PEER_QUERY_OK
        cdef size_t size = tox_public_key_size()
        cdef uint8_t *data = <uint8_t*> malloc(size * sizeof(uint8_t))
        try:
            tox_conference_peer_get_public_key(self._get(), conference_number, peer_number, data, &err)
            if err:
                raise ApiException(Tox_Err_Conference_Peer_Query(err))
            return data[:size]
        finally:
            free(data)

    def conference_offline_peer_get_public_key(self, conference_number: Tox_Conference_Number, offline_peer_number: Tox_Conference_Offline_Peer_Number) -> bytes:
        cdef Tox_Err_Conference_Peer_Query err = TOX_ERR_CONFERENCE_PEER_QUERY_OK
        cdef size_t size = tox_public_key_size()
        cdef uint8_t *data = <uint8_t*> malloc(size * sizeof(uint8_t))
        try:
            tox_conference_offline_peer_get_public_key(self._get(), conference_number, offline_peer_number, data, &err)
            if err:
                raise ApiException(Tox_Err_Conference_Peer_Query(err))
            return data[:size]
        finally:
            free(data)

    def conference_offline_peer_get_last_active(self, conference_number: Tox_Conference_Number, offline_peer_number: Tox_Conference_Offline_Peer_Number) -> int:
        cdef Tox_Err_Conference_Peer_Query err = TOX_ERR_CONFERENCE_PEER_QUERY_OK
        cdef int64_t res = tox_conference_offline_peer_get_last_active(self._get(), conference_number, offline_peer_number, &err)
        if err:
            raise ApiException(Tox_Err_Conference_Peer_Query(err))
        return res

    def conference_peer_number_is_ours(self, conference_number: Tox_Conference_Number, peer_number: Tox_Conference_Peer_Number) -> bool:
        cdef Tox_Err_Conference_Peer_Query err = TOX_ERR_CONFERENCE_PEER_QUERY_OK
        cdef bool res = tox_conference_peer_number_is_ours(self._get(), conference_number, peer_number, &err)
        if err:
            raise ApiException(Tox_Err_Conference_Peer_Query(err))
        return res

    @property
    def conference_chatlist(self) -> list[Tox_Conference_Number]:
        cdef size_t size = tox_conference_get_chatlist_size(self._get())
        cdef Tox_Conference_Number *data = <Tox_Conference_Number*> malloc(size * sizeof(Tox_Conference_Number))
        try:
            tox_conference_get_chatlist(self._get(), data)
            return [data[i] for i in range(size)]
        finally:
            free(data)

    def conference_get_id(self, conference_number: Tox_Conference_Number) -> bytes:
        cdef size_t size = tox_conference_id_size()
        cdef uint8_t *data = <uint8_t*> malloc(size * sizeof(uint8_t))
        try:
            if not tox_conference_get_id(self._get(), conference_number, data):
                raise ApiException(0)  # TODO(iphydf): There's no error enum for this. Make one.
            return data[:size]
        finally:
            free(data)

    def conference_by_id(self, id: bytes) -> Tox_Conference_Number:
        common.check_len("conference_id", id, tox_conference_id_size())
        cdef Tox_Err_Conference_By_Id err = TOX_ERR_CONFERENCE_BY_ID_OK
        cdef Tox_Conference_Number res = tox_conference_by_id(self._get(), id, &err)
        if err:
            raise ApiException(Tox_Err_Conference_By_Id(err))
        return res

    def conference_get_type(self, conference_number: Tox_Conference_Number) -> Tox_Conference_Type:
        cdef Tox_Err_Conference_Get_Type err = TOX_ERR_CONFERENCE_GET_TYPE_OK
        cdef Tox_Conference_Type res = tox_conference_get_type(self._get(), conference_number, &err)
        if err:
            raise ApiException(Tox_Err_Conference_Get_Type(err))
        return res

    def group_self_get_name(self, group_number: Tox_Group_Number) -> bytes:
        cdef Tox_Err_Group_Self_Query err = TOX_ERR_GROUP_SELF_QUERY_OK
        cdef size_t size = tox_group_self_get_name_size(self._get(), group_number, &err)
        if err:
            raise ApiException(Tox_Err_Group_Self_Query(err))
        cdef uint8_t *data = <uint8_t*> malloc(size * sizeof(uint8_t))
        try:
            tox_group_self_get_name(self._get(), group_number, data, &err)
            if err:
                raise ApiException(Tox_Err_Group_Self_Query(err))
            return data[:size]
        finally:
            free(data)

    def group_self_set_name(self, group_number: Tox_Group_Number, name: bytes) -> None:
        cdef Tox_Err_Group_Self_Name_Set err = TOX_ERR_GROUP_SELF_NAME_SET_OK
        tox_group_self_set_name(self._get(), group_number, name, len(name), &err)
        if err:
            raise ApiException(Tox_Err_Group_Self_Name_Set(err))

    def group_self_get_status(self, group_number: Tox_Group_Number) -> Tox_User_Status:
        cdef Tox_Err_Group_Self_Query err = TOX_ERR_GROUP_SELF_QUERY_OK
        cdef Tox_User_Status res = tox_group_self_get_status(self._get(), group_number, &err)
        if err:
            raise ApiException(Tox_Err_Group_Self_Query(err))
        return Tox_User_Status(res)

    def group_self_set_status(self, group_number: Tox_Group_Number, status: Tox_User_Status) -> None:
        cdef Tox_Err_Group_Self_Status_Set err = TOX_ERR_GROUP_SELF_STATUS_SET_OK
        tox_group_self_set_status(self._get(), group_number, status, &err)
        if err:
            raise ApiException(Tox_Err_Group_Self_Status_Set(err))

    def group_self_get_role(self, group_number: Tox_Group_Number) -> Tox_Group_Role:
        cdef Tox_Err_Group_Self_Query err = TOX_ERR_GROUP_SELF_QUERY_OK
        cdef Tox_Group_Role res = tox_group_self_get_role(self._get(), group_number, &err)
        if err:
            raise ApiException(Tox_Err_Group_Self_Query(err))
        return Tox_Group_Role(res)

    def group_self_get_peer_id(self, group_number: Tox_Group_Number) -> Tox_Group_Peer_Number:
        cdef Tox_Err_Group_Self_Query err = TOX_ERR_GROUP_SELF_QUERY_OK
        cdef Tox_Group_Peer_Number res = tox_group_self_get_peer_id(self._get(), group_number, &err)
        if err:
            raise ApiException(Tox_Err_Group_Self_Query(err))
        return res

    def group_self_get_public_key(self, group_number: Tox_Group_Number) -> bytes:
        cdef Tox_Err_Group_Self_Query err = TOX_ERR_GROUP_SELF_QUERY_OK
        cdef size_t size = tox_public_key_size()
        cdef uint8_t *data = <uint8_t*> malloc(size * sizeof(uint8_t))
        try:
            tox_group_self_get_public_key(self._get(), group_number, data, &err)
            if err:
                raise ApiException(Tox_Err_Group_Self_Query(err))
            return data[:size]
        finally:
            free(data)

    def group_peer_get_name(self, group_number: Tox_Group_Number, peer_id: Tox_Group_Peer_Number) -> bytes:
        cdef Tox_Err_Group_Peer_Query err = TOX_ERR_GROUP_PEER_QUERY_OK
        cdef size_t size = tox_group_peer_get_name_size(self._get(), group_number, peer_id, &err)
        if err:
            raise ApiException(Tox_Err_Group_Peer_Query(err))
        cdef uint8_t *data = <uint8_t*> malloc(size * sizeof(uint8_t))
        try:
            tox_group_peer_get_name(self._get(), group_number, peer_id, data, &err)
            if err:
                raise ApiException(Tox_Err_Group_Peer_Query(err))
            return data[:size]
        finally:
            free(data)

    def group_peer_get_status(self, group_number: Tox_Group_Number, peer_id: Tox_Group_Peer_Number) -> Tox_User_Status:
        cdef Tox_Err_Group_Peer_Query err = TOX_ERR_GROUP_PEER_QUERY_OK
        cdef Tox_User_Status res = tox_group_peer_get_status(self._get(), group_number, peer_id, &err)
        if err:
            raise ApiException(Tox_Err_Group_Peer_Query(err))
        return Tox_User_Status(res)

    def group_peer_get_role(self, group_number: Tox_Group_Number, peer_id: Tox_Group_Peer_Number) -> Tox_Group_Role:
        cdef Tox_Err_Group_Peer_Query err = TOX_ERR_GROUP_PEER_QUERY_OK
        cdef Tox_Group_Role res = tox_group_peer_get_role(self._get(), group_number, peer_id, &err)
        if err:
            raise ApiException(Tox_Err_Group_Peer_Query(err))
        return Tox_Group_Role(res)

    def group_peer_set_role(self, group_number: Tox_Group_Number, peer_id: Tox_Group_Peer_Number, role: Tox_Group_Role) -> None:
        cdef Tox_Err_Group_Set_Role err = TOX_ERR_GROUP_SET_ROLE_OK
        tox_group_set_role(self._get(), group_number, peer_id, role, &err)
        if err:
            raise ApiException(Tox_Err_Group_Set_Role(err))

    def group_peer_get_connection_status(self, group_number: Tox_Group_Number, peer_id: Tox_Group_Peer_Number) -> Tox_Connection:
        cdef Tox_Err_Group_Peer_Query err = TOX_ERR_GROUP_PEER_QUERY_OK
        cdef Tox_Connection res = tox_group_peer_get_connection_status(self._get(), group_number, peer_id, &err)
        if err:
            raise ApiException(Tox_Err_Group_Peer_Query(err))
        return Tox_Connection(res)

    def group_peer_get_public_key(self, group_number: Tox_Group_Number, peer_id: Tox_Group_Peer_Number) -> bytes:
        cdef Tox_Err_Group_Peer_Query err = TOX_ERR_GROUP_PEER_QUERY_OK
        cdef size_t size = tox_public_key_size()
        cdef uint8_t *data = <uint8_t*> malloc(size * sizeof(uint8_t))
        try:
            tox_group_peer_get_public_key(self._get(), group_number, peer_id, data, &err)
            if err:
                raise ApiException(Tox_Err_Group_Peer_Query(err))
            return data[:size]
        finally:
            free(data)

    def group_get_topic(self, group_number: Tox_Group_Number) -> bytes:
        cdef Tox_Err_Group_State_Query err = TOX_ERR_GROUP_STATE_QUERY_OK
        cdef size_t size = tox_group_get_topic_size(self._get(), group_number, &err)
        if err:
            raise ApiException(Tox_Err_Group_State_Query(err))
        cdef uint8_t *data = <uint8_t*> malloc(size * sizeof(uint8_t))
        try:
            tox_group_get_topic(self._get(), group_number, data, &err)
            if err:
                raise ApiException(Tox_Err_Group_State_Query(err))
            return data[:size]
        finally:
            free(data)

    def group_set_topic(self, group_number: Tox_Group_Number, topic: bytes) -> None:
        cdef Tox_Err_Group_Topic_Set err = TOX_ERR_GROUP_TOPIC_SET_OK
        tox_group_set_topic(self._get(), group_number, topic, len(topic), &err)
        if err:
            raise ApiException(Tox_Err_Group_Topic_Set(err))

    def group_get_name(self, group_number: Tox_Group_Number) -> bytes:
        cdef Tox_Err_Group_State_Query err = TOX_ERR_GROUP_STATE_QUERY_OK
        cdef size_t size = tox_group_get_name_size(self._get(), group_number, &err)
        if err:
            raise ApiException(Tox_Err_Group_State_Query(err))
        cdef uint8_t *data = <uint8_t*> malloc(size * sizeof(uint8_t))
        try:
            tox_group_get_name(self._get(), group_number, data, &err)
            if err:
                raise ApiException(Tox_Err_Group_State_Query(err))
            return data[:size]
        finally:
            free(data)

    def group_get_chat_id(self, group_number: Tox_Group_Number) -> bytes:
        cdef Tox_Err_Group_State_Query err = TOX_ERR_GROUP_STATE_QUERY_OK
        cdef size_t size = tox_group_chat_id_size()
        cdef uint8_t *data = <uint8_t*> malloc(size * sizeof(uint8_t))
        try:
            tox_group_get_chat_id(self._get(), group_number, data, &err)
            if err:
                raise ApiException(Tox_Err_Group_State_Query(err))
            return data[:size]
        finally:
            free(data)

    def group_get_number_groups(self) -> int:
        return tox_group_get_number_groups(self._get())

    def group_get_privacy_state(self, group_number: Tox_Group_Number) -> Tox_Group_Privacy_State:
        cdef Tox_Err_Group_State_Query err = TOX_ERR_GROUP_STATE_QUERY_OK
        cdef Tox_Group_Privacy_State res = tox_group_get_privacy_state(self._get(), group_number, &err)
        if err:
            raise ApiException(Tox_Err_Group_State_Query(err))
        return res

    def group_set_privacy_state(self, group_number: Tox_Group_Number, privacy_state: Tox_Group_Privacy_State) -> None:
        cdef Tox_Err_Group_Set_Privacy_State err = TOX_ERR_GROUP_SET_PRIVACY_STATE_OK
        tox_group_set_privacy_state(self._get(), group_number, privacy_state, &err)
        if err:
            raise ApiException(Tox_Err_Group_Set_Privacy_State(err))

    def group_get_voice_state(self, group_number: Tox_Group_Number) -> bool:
        cdef Tox_Err_Group_State_Query err = TOX_ERR_GROUP_STATE_QUERY_OK
        cdef bool res = tox_group_get_voice_state(self._get(), group_number, &err)
        if err:
            raise ApiException(Tox_Err_Group_State_Query(err))
        return res

    def group_set_voice_state(self, group_number: Tox_Group_Number, voice_state: Tox_Group_Voice_State) -> None:
        cdef Tox_Err_Group_Set_Voice_State err = TOX_ERR_GROUP_SET_VOICE_STATE_OK
        tox_group_set_voice_state(self._get(), group_number, voice_state, &err)
        if err:
            raise ApiException(Tox_Err_Group_Set_Voice_State(err))

    def group_get_topic_lock(self, group_number: Tox_Group_Number) -> Tox_Group_Topic_Lock:
        cdef Tox_Err_Group_State_Query err = TOX_ERR_GROUP_STATE_QUERY_OK
        cdef Tox_Group_Topic_Lock res = tox_group_get_topic_lock(self._get(), group_number, &err)
        if err:
            raise ApiException(Tox_Err_Group_State_Query(err))
        return Tox_Group_Topic_Lock(res)

    def group_set_topic_lock(self, group_number: Tox_Group_Number, topic_lock: Tox_Group_Topic_Lock) -> None:
        cdef Tox_Err_Group_Set_Topic_Lock err = TOX_ERR_GROUP_SET_TOPIC_LOCK_OK
        tox_group_set_topic_lock(self._get(), group_number, topic_lock, &err)
        if err:
            raise ApiException(Tox_Err_Group_Set_Topic_Lock(err))

    def group_get_peer_limit(self, group_number: Tox_Group_Number) -> int:
        cdef Tox_Err_Group_State_Query err = TOX_ERR_GROUP_STATE_QUERY_OK
        cdef uint32_t res = tox_group_get_peer_limit(self._get(), group_number, &err)
        if err:
            raise ApiException(Tox_Err_Group_State_Query(err))
        return res

    def group_set_peer_limit(self, group_number: Tox_Group_Number, limit: int) -> None:
        cdef Tox_Err_Group_Set_Peer_Limit err = TOX_ERR_GROUP_SET_PEER_LIMIT_OK
        tox_group_set_peer_limit(self._get(), group_number, limit, &err)
        if err:
            raise ApiException(Tox_Err_Group_Set_Peer_Limit(err))

    def group_get_password(self, group_number: Tox_Group_Number) -> bytes:
        cdef Tox_Err_Group_State_Query err = TOX_ERR_GROUP_STATE_QUERY_OK
        cdef size_t size = tox_group_get_password_size(self._get(), group_number, &err)
        if err:
            raise ApiException(Tox_Err_Group_State_Query(err))
        cdef uint8_t *data = <uint8_t*> malloc(size * sizeof(uint8_t))
        try:
            tox_group_get_password(self._get(), group_number, data, &err)
            if err:
                raise ApiException(Tox_Err_Group_State_Query(err))
            return data[:size]
        finally:
            free(data)

    def group_set_password(self, group_number: Tox_Group_Number, password: bytes) -> None:
        cdef Tox_Err_Group_Set_Password err = TOX_ERR_GROUP_SET_PASSWORD_OK
        # TODO(iphydf): Rename this function to tox_group_set_password.
        tox_group_set_password(self._get(), group_number, password, len(password), &err)
        if err:
            raise ApiException(Tox_Err_Group_Set_Password(err))

    def group_set_ignore(self, group_number: Tox_Group_Number, peer_id: Tox_Group_Peer_Number, ignore: bool) -> None:
        cdef Tox_Err_Group_Set_Ignore err = TOX_ERR_GROUP_SET_IGNORE_OK
        tox_group_set_ignore(self._get(), group_number, peer_id, ignore, &err)
        if err:
            raise ApiException(Tox_Err_Group_Set_Ignore(err))

    def group_kick_peer(self, group_number: Tox_Group_Number, peer_id: Tox_Group_Peer_Number) -> None:
        cdef Tox_Err_Group_Kick_Peer err = TOX_ERR_GROUP_KICK_PEER_OK
        tox_group_kick_peer(self._get(), group_number, peer_id, &err)
        if err:
            raise ApiException(Tox_Err_Group_Kick_Peer(err))

    def group_new(self, privacy_state: Tox_Group_Privacy_State, group_name: bytes, name: bytes) -> Tox_Group_Number:
        cdef Tox_Err_Group_New err = TOX_ERR_GROUP_NEW_OK
        cdef Tox_Group_Number res = tox_group_new(self._get(), privacy_state, group_name, len(group_name), name, len(name), &err)
        if err:
            raise ApiException(Tox_Err_Group_New(err))
        return res

    def group_join(self, chat_id: bytes, name: bytes, password: bytes) -> Tox_Group_Number:
        common.check_len("chat_id", chat_id, tox_group_chat_id_size())
        cdef Tox_Err_Group_Join err = TOX_ERR_GROUP_JOIN_OK
        cdef Tox_Group_Number res = tox_group_join(self._get(), chat_id, name, len(name), password, len(password), &err)
        if err:
            raise ApiException(Tox_Err_Group_Join(err))
        return res

    def group_is_connected(self, group_number: Tox_Group_Number) -> bool:
        cdef Tox_Err_Group_Is_Connected err = TOX_ERR_GROUP_IS_CONNECTED_OK
        cdef bool res = tox_group_is_connected(self._get(), group_number, &err)
        if err:
            raise ApiException(Tox_Err_Group_Is_Connected(err))
        return res

    def group_disconnect(self, group_number: Tox_Group_Number) -> None:
        cdef Tox_Err_Group_Disconnect err = TOX_ERR_GROUP_DISCONNECT_OK
        tox_group_disconnect(self._get(), group_number, &err)
        if err:
            raise ApiException(Tox_Err_Group_Disconnect(err))

    def group_leave(self, group_number: Tox_Group_Number, part_message: bytes) -> None:
        cdef Tox_Err_Group_Leave err = TOX_ERR_GROUP_LEAVE_OK
        tox_group_leave(self._get(), group_number, part_message, len(part_message), &err)
        if err:
            raise ApiException(Tox_Err_Group_Leave(err))

    def group_send_message(self, group_number: Tox_Group_Number, type_: Tox_Message_Type, message: bytes) -> Tox_Group_Message_Id:
        cdef Tox_Err_Group_Send_Message err = TOX_ERR_GROUP_SEND_MESSAGE_OK
        cdef Tox_Group_Message_Id res = tox_group_send_message(self._get(), group_number, type_, message, len(message), &err)
        if err:
            raise ApiException(Tox_Err_Group_Send_Message(err))
        return res

    def group_send_private_message(self, group_number: Tox_Group_Number, peer_id: Tox_Group_Peer_Number, type_: Tox_Message_Type, message: bytes) -> None:
        cdef Tox_Err_Group_Send_Private_Message err = TOX_ERR_GROUP_SEND_PRIVATE_MESSAGE_OK
        tox_group_send_private_message(self._get(), group_number, peer_id, type_, message, len(message), &err)
        if err:
            raise ApiException(Tox_Err_Group_Send_Private_Message(err))

    def group_send_custom_packet(self, group_number: Tox_Group_Number, lossless: bool, data: bytes) -> None:
        cdef Tox_Err_Group_Send_Custom_Packet err = TOX_ERR_GROUP_SEND_CUSTOM_PACKET_OK
        tox_group_send_custom_packet(self._get(), group_number, lossless, data, len(data), &err)
        if err:
            raise ApiException(Tox_Err_Group_Send_Custom_Packet(err))

    def group_send_custom_private_packet(self, group_number: Tox_Group_Number, peer_id: Tox_Group_Peer_Number, lossless: bool, data: bytes) -> None:
        cdef Tox_Err_Group_Send_Custom_Private_Packet err = TOX_ERR_GROUP_SEND_CUSTOM_PRIVATE_PACKET_OK
        tox_group_send_custom_private_packet(self._get(), group_number, peer_id, lossless, data, len(data), &err)
        if err:
            raise ApiException(Tox_Err_Group_Send_Custom_Private_Packet(err))

    def group_invite_friend(self, group_number: Tox_Group_Number, friend_number: Tox_Friend_Number) -> None:
        cdef Tox_Err_Group_Invite_Friend err = TOX_ERR_GROUP_INVITE_FRIEND_OK
        tox_group_invite_friend(self._get(), group_number, friend_number, &err)
        if err:
            raise ApiException(Tox_Err_Group_Invite_Friend(err))

    def group_invite_accept(self, friend_number: Tox_Friend_Number, invite_data: bytes, name: bytes, password: bytes) -> Tox_Group_Number:
        cdef Tox_Err_Group_Invite_Accept err = TOX_ERR_GROUP_INVITE_ACCEPT_OK
        cdef Tox_Group_Number res = tox_group_invite_accept(self._get(), friend_number, invite_data, len(invite_data), name, len(name), password, len(password), &err)
        if err:
            raise ApiException(Tox_Err_Group_Invite_Accept(err))
        return res


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

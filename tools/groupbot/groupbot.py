# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2025 The TokTok team
"""A simple Tox group bot.

If someone adds this bot as a friend, it will invite them to a conference.
The conference is linked to a group chat, so messages sent to the conference
will be forwarded to the group chat and vice versa.

The bot only supports connecting through tor (or another SOCKS5 proxy running
on localhost:9050).

Usage:

    bazel run //py_toxcore_c/tools/groupbot -- \
        --savefile="$PWD/py_toxcore_c/tools/groupbot/groupbot.tox" \
        --password="$GROUPBOT_PASSWORD"

The checked-in savefile contains the tox ID
648BF2EEE794E94444B848F8FC6AD3BA029C9BC2649BA761EF556DA17F549022A8D7596E7DBA
Ask @iphydf for the password if you want to run the bot.
"""
import time
from typing import Any

from py_toxcore_c.tools.groupbot import api
from py_toxcore_c.tools.groupbot import commands
from py_toxcore_c.tools.groupbot import nodes

import pytox.toxcore.tox as core


class GroupBot(api.GroupBot):
    cmds: commands.Commands

    def __init__(self, config: api.Config) -> None:
        self.cmds = commands.Commands(config)

        data = self.load(config)

        with core.Tox_Options_Ptr() as options:
            options.experimental_owned_data = True
            options.experimental_disable_dns = True
            options.experimental_groups_persistence = True
            options.local_discovery_enabled = False
            options.udp_enabled = False
            options.proxy_host = "127.0.0.1"
            options.proxy_port = 9050
            options.proxy_type = core.TOX_PROXY_TYPE_SOCKS5
            if data:
                options.savedata = data
                options.savedata_type = core.TOX_SAVEDATA_TYPE_TOX_SAVE
            super().__init__(config, options)

        # These are already set to something by self.load().
        # pylint: disable-next=access-member-before-definition
        if not self.name:
            self.name = config.nick.encode()
        # pylint: disable-next=access-member-before-definition
        if not self.status_message:
            self.status_message = config.status_message.encode()

    def handle_self_connection_status(
            self, connection_status: core.Tox_Connection) -> None:
        print("Connection status:", connection_status.name)

    def handle_friend_request(self, public_key: bytes, message: bytes) -> None:
        print("Friend request:", public_key.hex(), message.decode())
        self.friend_add_norequest(public_key)
        self.save()

    def handle_friend_connection_status(
            self, friend_number: int,
            connection_status: core.Tox_Connection) -> None:
        print("Friend connection status:", friend_number,
              connection_status.name)
        if connection_status != core.TOX_CONNECTION_NONE:
            if self.conference_chatlist:
                # Invite to conference.
                self.conference_invite(friend_number, 0)

    def handle_friend_message(self, friend_number: int,
                              type_: core.Tox_Message_Type,
                              message: bytes) -> None:
        print("Friend message:", friend_number, type_.name, message.decode())

    def handle_conference_invite(self, friend_number: int,
                                 type_: core.Tox_Conference_Type,
                                 cookie: bytes) -> None:
        print("Conference invite:", friend_number, type_.name, cookie)
        if friend_number != 0:
            print("Ignoring")
            return
        self.conference_join(friend_number, cookie)

    def handle_group_invite(self, friend_number: int, invite_data: bytes,
                            group_name: bytes) -> None:
        print("Group invite:", friend_number, group_name)
        if friend_number != 0:
            print("Ignoring")
            return
        self.group_invite_accept(friend_number, invite_data, self.name, b"")

    def handle_group_message(
        self,
        group_number: int,
        peer_id: int,
        message_type: core.Tox_Message_Type,
        message: bytes,
        message_id: int,
    ) -> None:
        print("Group message:", group_number, peer_id, message_type.name,
              message.decode())
        peer = self.group_peer_get_name(group_number, peer_id).decode()
        if not self.conference_chatlist:
            return
        if message.startswith(b"~"):
            return
        if message.startswith(b"!"):
            reply = self.cmds.handle(
                self,
                self.group_peer_get_public_key(group_number, peer_id),
                message_type,
                message[1:],
            )
            if reply:
                self.group_send_message(
                    group_number,
                    reply.message_type,
                    f"{peer}: {reply.text}".encode(),
                )
        else:
            self.conference_send_message(
                0, message_type, f"<{peer}> {message.decode()}".encode())

    def handle_conference_message(
        self,
        conference_number: int,
        peer_number: int,
        type_: core.Tox_Message_Type,
        message: bytes,
    ) -> None:
        if self.conference_peer_number_is_ours(conference_number, peer_number):
            return
        print(
            "Conference message:",
            conference_number,
            peer_number,
            type_.name,
            message.decode(),
        )
        if message.startswith(b"~"):
            return
        peer = self.conference_get_peer_name(conference_number,
                                             peer_number).decode()
        if message.startswith(b"!"):
            reply = self.cmds.handle(
                self,
                self.conference_peer_get_public_key(conference_number,
                                                    peer_number),
                type_,
                message[1:],
            )
            if reply:
                self.conference_send_message(
                    conference_number,
                    reply.message_type,
                    f"{peer}: {reply.text}".encode(),
                )
        else:
            self.group_send_message(0, type_,
                                    f"<{peer}> {message.decode()}".encode())


class ToxSaver:

    def __init__(self, tox: GroupBot) -> None:
        self.tox = tox

    def __enter__(self) -> "ToxSaver":
        return self

    def __exit__(self, exc_type: Any, exc_value: Any, traceback: Any) -> None:
        self.tox.save()


def main(config: api.Config) -> None:
    with GroupBot(config) as bot:
        with ToxSaver(bot):
            print("Bot ID:", bot.address.hex().upper())
            for node in nodes.get_nodes(config.nodes_url, 4):
                if not node.ipv4:
                    continue
                print(f"Connecting to {node.ipv4}:{node.port}")
                bot.bootstrap(node.ipv4, node.port,
                              bytes.fromhex(node.public_key))
                if node.tcp_ports:
                    bot.add_tcp_relay(node.ipv4, node.tcp_ports[0],
                                      bytes.fromhex(node.public_key))
            while True:
                try:
                    bot.iterate()
                except core.ApiException as e:
                    print("Error:", e)
                time.sleep(bot.iteration_interval / 1000)


if __name__ == "__main__":
    main(api.parse_args())

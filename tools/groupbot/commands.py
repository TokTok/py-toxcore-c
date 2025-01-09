# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2025 The TokTok team
import importlib
import shlex
import sys
from typing import Optional

from py_toxcore_c.tools.groupbot import api
from py_toxcore_c.tools.groupbot.plugins import github

import pytox.toxcore.tox as core


def _reload_modules() -> None:
    """Reload the extension modules."""
    for name in tuple(sys.modules.keys()):
        if name.startswith("py_toxcore_c.tools.groupbot.plugins."):
            importlib.reload(sys.modules[name])


class Commands:
    _gh: github.GitHub

    def __init__(self, config: api.Config) -> None:
        self._gh = github.GitHub(config.github_path)

    def _reload(self) -> None:
        """Reload the extension modules."""
        _reload_modules()
        self._gh = github.GitHub(self._gh.path)

    def handle(
        self,
        bot: api.GroupBot,
        friend_pk: bytes,
        message_type: core.Tox_Message_Type,
        message: bytes,
    ) -> Optional[api.Reply]:
        """Handle a command."""
        try:
            command = shlex.split(message.decode("utf-8"))
        except ValueError as e:
            return api.Reply(f"Error: {e}")
        if not command:
            return None
        try:
            fun = self._dispatch(command[0])
            if fun:
                return fun(bot, friend_pk, message_type, tuple(command[1:]))
        except Exception as e:
            return api.Reply(f"Error: {e}")
        return None

    def _dispatch(self, command: str) -> Optional[api.CommandFunction]:
        """Dispatch a command."""
        if command == "echo":
            return self.echo
        if command == "gh":
            return self.gh
        if command == "leave":
            return self.leave
        if command == "nick":
            return self.nick
        if command == "reload":
            return self.reload
        if command == "save":
            return self.save
        return None

    def echo(
        self,
        bot: api.GroupBot,
        friend_pk: bytes,
        message_type: core.Tox_Message_Type,
        message: tuple[str, ...],
    ) -> Optional[api.Reply]:
        """Echo a message."""
        return api.Reply(str(list(message)))

    def gh(
        self,
        bot: api.GroupBot,
        friend_pk: bytes,
        message_type: core.Tox_Message_Type,
        params: tuple[str, ...],
    ) -> Optional[api.Reply]:
        """Provide access to GitHub issue/PR information."""
        return self._gh.handle(bot, friend_pk, message_type, params)

    @api.admin
    def leave(
        self,
        bot: api.GroupBot,
        friend_pk: bytes,
        message_type: core.Tox_Message_Type,
        params: tuple[str, ...],
    ) -> Optional[api.Reply]:
        """Leave the conference."""
        bot.conference_delete(0)
        bot.group_leave(0, b"Goodbye!")
        return None

    @api.admin
    def nick(
        self,
        bot: api.GroupBot,
        friend_pk: bytes,
        message_type: core.Tox_Message_Type,
        params: tuple[str, ...],
    ) -> Optional[api.Reply]:
        """Set the bot's nickname."""
        if not params:
            return api.Reply("Usage: !nick <nickname>")
        bot.name = params[0].encode()
        bot.group_self_set_name(0, bot.name)
        return None

    @api.admin
    def reload(
        self,
        bot: api.GroupBot,
        friend_pk: bytes,
        message_type: core.Tox_Message_Type,
        params: tuple[str, ...],
    ) -> Optional[api.Reply]:
        """Reload the extension modules."""
        self._reload()
        return api.Reply("Modules reloaded.")

    @api.admin
    def save(
        self,
        bot: api.GroupBot,
        friend_pk: bytes,
        message_type: core.Tox_Message_Type,
        params: tuple[str, ...],
    ) -> Optional[api.Reply]:
        """Save the groupbot state to disk."""
        bot.save()
        return api.Reply("State saved.")

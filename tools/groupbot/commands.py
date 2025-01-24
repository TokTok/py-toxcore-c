# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2025 The TokTok team
import importlib
import shlex
import sys
from dataclasses import dataclass
from typing import Callable
from typing import Optional

from py_toxcore_c.tools.groupbot import api
from py_toxcore_c.tools.groupbot.plugins import echo
from py_toxcore_c.tools.groupbot.plugins import github

import pytox.toxcore.tox as core


@dataclass
class Module:
    """A groupbot module."""

    prefix: str
    new: Callable[[api.Config], api.Handler]
    clone: Callable[[api.HandlerData], api.Handler]


def _reload_modules() -> tuple[Module, ...]:
    """Reload the extension modules."""
    for name in tuple(sys.modules.keys()):
        if name.startswith("py_toxcore_c.tools.groupbot.plugins."):
            importlib.reload(sys.modules[name])

    return (
        Module("echo", echo.Echo.new, echo.Echo.clone),
        Module("gh", github.GitHub.new, github.GitHub.clone),
    )


class Commands:
    _handlers: dict[str, api.Handler]

    def __init__(self, config: api.Config) -> None:
        self._handlers = {
            mod.prefix: mod.new(config)
            for mod in _reload_modules()
        }

    def _reload(self) -> None:
        """Reload the extension modules."""
        self._handlers = {
            mod.prefix: mod.clone(self._handlers[mod.prefix].data())
            for mod in _reload_modules()
        }

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
            return self._dispatch(command[0])(bot, friend_pk, message_type,
                                              tuple(command[1:]))
        except Exception as e:
            return api.Reply(f"Error: {e}")
        return None

    def _dispatch(self, command: str) -> api.CommandFunction:
        """Dispatch a command."""
        if command == "leave":
            return self.leave
        if command == "nick":
            return self.nick
        if command == "reload":
            return self.reload
        if command == "save":
            return self.save
        if command in self._handlers:
            return self._handlers[command].handle
        return self.null

    def null(
        self,
        bot: api.GroupBot,
        friend_pk: bytes,
        message_type: core.Tox_Message_Type,
        params: tuple[str, ...],
    ) -> Optional[api.Reply]:
        """Null command."""
        return None

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

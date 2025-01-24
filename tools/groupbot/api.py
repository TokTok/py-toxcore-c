# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2025 The TokTok team
import argparse
import os
from dataclasses import dataclass
from typing import Callable
from typing import Optional
from typing import TypeVar

import pytox.toxcore.tox as core
import pytox.toxencryptsave.toxencryptsave as encryptsave

BUILD_WORKSPACE_DIRECTORY = os.getenv("BUILD_WORKSPACE_DIRECTORY")


@dataclass
class Config:
    savefile: str
    old_password: Optional[str]
    password: Optional[str]
    nick: str
    status_message: str
    nodes_url: str
    github_path: str


def parse_args() -> Config:
    parser = argparse.ArgumentParser(description="""
    A simple Tox group bot.
    """)
    parser.add_argument(
        "--savefile",
        help="Path to Tox save data",
        required=BUILD_WORKSPACE_DIRECTORY is None,
        default=(os.path.join(
            BUILD_WORKSPACE_DIRECTORY,
            "py_toxcore_c",
            "tools",
            "groupbot",
            "groupbot.tox",
        ) if BUILD_WORKSPACE_DIRECTORY is not None else None),
    )
    parser.add_argument(
        "--old-password",
        help=("Old password for save data decryption "
              "(defaults to the value passed to --password)"),
    )
    parser.add_argument(
        "--password",
        help="Password for save data encryption",
    )
    parser.add_argument(
        "--nick",
        help="Nickname",
        default="ToxGroupBot",
    )
    parser.add_argument(
        "--status-message",
        help="Status message",
        default="Tox Group Bot",
    )
    parser.add_argument(
        "--nodes-url",
        help="URL to fetch nodes from",
        default="https://nodes.tox.chat/json",
    )
    parser.add_argument(
        "--github-path",
        help="Path to the GitHub backup directory",
        required=BUILD_WORKSPACE_DIRECTORY is None,
        default=(os.path.join(
            BUILD_WORKSPACE_DIRECTORY,
            "tools",
            "toktok-backup",
        ) if BUILD_WORKSPACE_DIRECTORY is not None else None),
    )
    return Config(**vars(parser.parse_args()))


class GroupBot(core.Tox_Ptr):
    config: Config

    def __init__(self, config: Config, options: core.Tox_Options_Ptr) -> None:
        super().__init__(options)
        self.config = config

    def load(self, config: Config) -> Optional[bytes]:
        if os.path.exists(config.savefile):
            with open(config.savefile, "rb") as file:
                data = file.read()
                if not encryptsave.is_data_encrypted(data):
                    return data
                password = config.old_password or config.password
                if password is None:
                    raise ValueError("Password required to decrypt save data")
                return encryptsave.pass_decrypt(data, password.encode())
        else:
            return None

    def save(self) -> None:
        data = self.savedata
        if self.config.password is not None:
            data = encryptsave.pass_encrypt(data,
                                            self.config.password.encode())
        with open(self.config.savefile, "wb") as file:
            file.write(data)


@dataclass
class Reply:
    text: str
    message_type: core.Tox_Message_Type = core.TOX_MESSAGE_TYPE_NORMAL


T = TypeVar("T")

CommandFunction = Callable[
    [GroupBot, bytes, core.Tox_Message_Type, tuple[str, ...]], Optional[Reply]]
CommandMethod = Callable[
    [T, GroupBot, bytes, core.Tox_Message_Type, tuple[str,
                                                      ...]], Optional[Reply]]


def admin(func: CommandMethod[T]) -> CommandMethod[T]:
    """Checks if friend is number 0."""

    def wrapper(
        self: T,
        bot: GroupBot,
        friend_pk: bytes,
        message_type: core.Tox_Message_Type,
        params: tuple[str, ...],
    ) -> Optional[Reply]:
        if friend_pk != bot.friend_get_public_key(0):
            return Reply("You must be an admin to use this command.")
        return func(self, bot, friend_pk, message_type, params)

    return wrapper


@dataclass
class HandlerData:
    """Serializable handler data."""

    data: dict[str, str]

    def __init__(self, **data: str) -> None:
        self.data = data


class Handler:

    def handle(
        self,
        bot: GroupBot,
        friend_pk: bytes,
        message_type: core.Tox_Message_Type,
        message: tuple[str, ...],
    ) -> Optional[Reply]:
        """Handle a Tox message."""
        raise NotImplementedError

    def data(self) -> HandlerData:
        """Get the handler data usable to clone a handler."""
        return HandlerData()

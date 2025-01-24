# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2025 The TokTok team
from typing import Optional

from py_toxcore_c.tools.groupbot import api

import pytox.toxcore.tox as core


class Echo(api.Handler):

    @staticmethod
    def new(config: api.Config) -> "Echo":
        """Create a Echo module instance from a configuration."""
        return Echo()

    @staticmethod
    def clone(data: api.HandlerData) -> "Echo":
        """Clone a module instance."""
        return Echo()

    def handle(
        self,
        bot: api.GroupBot,
        friend_pk: bytes,
        message_type: core.Tox_Message_Type,
        message: tuple[str, ...],
    ) -> Optional[api.Reply]:
        """Handle a Tox message."""
        return api.Reply(str(list(message)), message_type)

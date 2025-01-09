# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2025 The TokTok team
import socket
from dataclasses import dataclass
from functools import cache as memoize
from typing import Any
from typing import Optional

import requests


@dataclass
class Node:
    ipv4: Optional[str]
    ipv6: Optional[str]
    port: int
    tcp_ports: list[int]
    public_key: str
    maintainer: str
    location: str
    status_udp: bool
    status_tcp: bool
    version: str
    motd: str
    last_ping: int

    @staticmethod
    def from_dict(data: dict[str, Any]) -> "Node":
        return Node(
            ipv4=data.get("ipv4"),
            ipv6=data.get("ipv6"),
            port=data["port"],
            tcp_ports=sorted(data["tcp_ports"]),
            public_key=data["public_key"],
            maintainer=data["maintainer"],
            location=data["location"],
            status_udp=data["status_udp"],
            status_tcp=data["status_tcp"],
            version=data["version"],
            motd=data["motd"],
            last_ping=int(data["last_ping"]),
        )


def _get_nodes(url: str) -> list[Node]:
    response = requests.get(url)
    return [Node.from_dict(node) for node in response.json()["nodes"]]


@memoize
def _resolve(host: str, port: int,
             family: socket.AddressFamily) -> Optional[str]:
    """Resolve a hostname to an IP address."""
    try:
        result = socket.getaddrinfo(host, port, family, socket.SOCK_DGRAM)
        if not result:
            return None
        address = result[0][4][0]
        print(f"Resolved {host}:{port} ({family.name}) to {address}")
        return address
    except socket.error:
        return None


def _resolve_nodes(nodes: list[Node]) -> None:
    for node in nodes:
        if node.ipv4:
            node.ipv4 = _resolve(node.ipv4, node.port, socket.AF_INET)
        if node.ipv6:
            node.ipv6 = _resolve(node.ipv6, node.port, socket.AF_INET6)


def get_nodes(url: str, count: int) -> list[Node]:
    nodes = sorted(
        _get_nodes(url),
        key=lambda node: node.last_ping,
        reverse=True,
    )[:count]
    _resolve_nodes(nodes)
    return nodes

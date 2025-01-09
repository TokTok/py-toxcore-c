# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2025 The TokTok team
"""API on top of a GitHub backup directory (no GitHub API calls).

This module provides an API on top of a GitHub backup directory. It is
intended to be used in a groupbot to provide access to GitHub issue
information without making any GitHub API calls.
"""
import json
import os
from dataclasses import dataclass
from functools import cache as memoize
from typing import Any
from typing import Optional

from py_toxcore_c.tools.groupbot import api

import pytox.toxcore.tox as core


def _is_int(value: str) -> bool:
    """Check if a string is an integer."""
    try:
        int(value)
        return True
    except ValueError:
        return False


@dataclass
class RepoPath:
    path: str

    name: str

    def __hash__(self) -> int:
        return hash(self.path)

    def __eq__(self, other: object) -> bool:
        return isinstance(other, RepoPath) and self.path == other.path

    def __lt__(self, other: "RepoPath") -> bool:
        return self.name < other.name


@dataclass
class IssuePath:
    path: str

    repo: RepoPath
    number: int
    is_pull_request: bool

    def __hash__(self) -> int:
        return hash(self.path)

    def __eq__(self, other: object) -> bool:
        return isinstance(other, IssuePath) and self.path == other.path

    def __lt__(self, other: "IssuePath") -> bool:
        return self.number < other.number


@dataclass
class User:
    login: str

    @staticmethod
    def fromJSON(user: dict[str, Any]) -> "User":
        return User(login=str(user["login"]))


@dataclass
class Issue:
    path: IssuePath
    number: int
    title: str
    state: str
    user: User
    is_pull_request: bool

    @property
    def repo(self) -> str:
        return self.path.repo.name

    @staticmethod
    def fromJSON(path: IssuePath, issue: dict[str, Any]) -> "Issue":
        return Issue(
            path=path,
            number=int(issue["number"]),
            title=str(issue["title"]),
            state=str(issue["state"]),
            user=User.fromJSON(issue["user"]),
            is_pull_request=bool(issue.get("pull_request")),
        )


@dataclass
class GitHub:
    path: str

    def __hash__(self) -> int:
        return hash(self.path)

    def __eq__(self, other: object) -> bool:
        return isinstance(other, GitHub) and self.path == other.path

    def handle(
        self,
        bot: api.GroupBot,
        friend_pk: bytes,
        message_type: core.Tox_Message_Type,
        message: tuple[str, ...],
    ) -> Optional[api.Reply]:
        """Handle a Tox message."""
        return self.handle_cli(message)

    def handle_cli(self, message: tuple[str, ...]) -> Optional[api.Reply]:
        """Handle a command-line message."""
        if len(message) == 1 and message[0].startswith("#"):
            return self.handle_issue(None, message[0][1:])
        if len(message) == 1 and _is_int(message[0]):
            return self.handle_issue(None, message[0])
        if len(message) == 1 and "#" in message[0]:
            repo_name, issue_id = message[0].split("#", 1)
            return self.handle_issue(repo_name, issue_id)

        return None

    def handle_issue(self, repo_name: Optional[str],
                     issue_id: str) -> api.Reply:
        """Handle an issue/PR number."""
        try:
            issue_number = int(issue_id)
        except ValueError:
            return api.Reply(f"Error: {issue_id} is not a valid issue number")

        issues: list[Issue] = []
        repos = (self.repos() if repo_name is None else [
            repo for repo in self.repos()
            if repo.name.lower() == repo_name.lower()
        ])
        if not repos:
            return api.Reply(f"Error: Repository {repo_name} not found")
        for repo in repos:
            for issue_path in self.issues(repo):
                if issue_path.number == issue_number:
                    issues.append(self.load_issue(issue_path))

        repo_name = repo_name or "any repository"

        # If any issues were found, return the first one that's open. If none
        # are open, return the first one.
        issue: Optional[Issue] = None
        for candidate in issues:
            if candidate.state == "open":
                break
        else:
            issue = issues[0] if issues else None
        if issue:
            return api.Reply(
                f"{issue.title} by {issue.user.login} ({issue.repo}#{issue.number}, {issue.state})"
            )

        return api.Reply(
            f"Error: Issue {issue_number} not found in {repo_name}")

    @memoize
    def load_issue(self, issue: IssuePath) -> Issue:
        """Get the issue/PR information."""
        with open(issue.path, "rb") as file:
            return Issue.fromJSON(issue, json.load(file))

    @memoize
    def repos(self) -> list[RepoPath]:
        """Get the list of repositories in the backup directory."""
        repo_path = os.path.join(self.path, "repositories")
        return sorted(
            RepoPath(os.path.join(repo_path, name), name)
            for name in os.listdir(repo_path))

    @memoize
    def issues(self, repo: RepoPath) -> list[IssuePath]:
        """Get the list of issues/PRs for the given repository."""
        issues: list[IssuePath] = []

        issues_path = os.path.join(repo.path, "issues")
        issues.extend(
            IssuePath(
                os.path.join(issues_path, issue),
                repo,
                int(issue.removesuffix(".json")),
                is_pull_request=False,
            ) for issue in os.listdir(issues_path))

        pulls_path = os.path.join(repo.path, "pulls")
        issues.extend(
            IssuePath(
                os.path.join(pulls_path, issue),
                repo,
                int(issue.removesuffix(".json")),
                is_pull_request=True,
            ) for issue in os.listdir(pulls_path))

        return sorted(issues)


if __name__ == "__main__":
    import sys

    if api.BUILD_WORKSPACE_DIRECTORY is None:
        api.BUILD_WORKSPACE_DIRECTORY = os.path.abspath(
            os.path.dirname(
                os.path.dirname(os.path.dirname(os.path.dirname(__file__)))))
    github_path = os.path.join(api.BUILD_WORKSPACE_DIRECTORY, "tools",
                               "toktok-backup")

    gh = GitHub(github_path)
    reply = gh.handle_cli(tuple(sys.argv[1:]))
    if reply is not None:
        print(reply.text)

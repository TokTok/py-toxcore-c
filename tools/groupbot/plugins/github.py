# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2025 The TokTok team
"""API on top of a GitHub backup directory (no GitHub API calls).

This module provides an API on top of a GitHub backup directory. It is
intended to be used in a groupbot to provide access to GitHub issue
information without making any GitHub API calls.
"""
import json
import os
import subprocess  # nosec
import time
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

    @property
    def repo(self) -> str:
        return self.path.repo.name

    @property
    def is_pull_request(self) -> bool:
        return self.path.is_pull_request

    @property
    def emoji(self) -> str:
        """Get an emoji to distinguish between issue and PR."""
        return "🎁" if self.is_pull_request else "🐛"

    @staticmethod
    def fromJSON(path: IssuePath, issue: dict[str, Any]) -> "Issue":
        return Issue(
            path=path,
            number=int(issue["number"]),
            title=str(issue["title"]),
            state=str(issue["state"]),
            user=User.fromJSON(issue["user"]),
        )


@dataclass
class GitHub(api.Handler):
    path: str
    last_update: float = 0

    @staticmethod
    def new(config: api.Config) -> "GitHub":
        """Create a GitHub instance from a configuration."""
        return GitHub(config.github_path)

    @staticmethod
    def clone(data: api.HandlerData) -> "GitHub":
        """Clone a GitHub instance."""
        if "path" not in data.data:
            raise ValueError("Missing path in HandlerData")
        return GitHub(data.data["path"])

    def data(self) -> api.HandlerData:
        """Get the module data."""
        return api.HandlerData(path=self.path)

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
        if len(message) == 1 and message[0] == "update":
            return self.handle_update()

        return None

    def _find_issue(
            self, repo_name: Optional[str],
            issue_number: int) -> tuple[Optional[str], Optional[Issue]]:
        """Find an issue/PR by number."""
        candidates: list[Issue] = []
        repos = (self.repos() if repo_name is None else [
            repo for repo in self.repos()
            if repo.name.lower().startswith(repo_name.lower())
        ])
        if not repos:
            return None, None
        for repo in repos:
            for issue_path in self.issues(repo):
                if issue_path.number == issue_number:
                    candidates.append(self.load_issue(issue_path))

        if len(repos) == 1:
            repo_name = repos[0].name
        repo_name = repo_name or "any repository"

        # If any issues were found, return the first one that's open. If none
        # are open, return the first one.
        issue: Optional[Issue] = None
        for candidate in candidates:
            if candidate.state == "open":
                issue = candidate
                break
        else:
            issue = candidates[0] if candidates else None

        return repo_name, issue

    def handle_issue(self, repo_name: Optional[str],
                     issue_id: str) -> api.Reply:
        """Handle an issue/PR number."""
        try:
            issue_number = int(issue_id)
        except ValueError:
            return api.Reply(f"Error: {issue_id} is not a valid issue number")

        found_repo, issue = self._find_issue(repo_name, issue_number)
        if not found_repo:
            return api.Reply(f"Error: Repository {repo_name} not found")
        if not issue:
            return api.Reply(
                f"Error: Issue {issue_number} not found in {found_repo}")

        return api.Reply(f"{issue.emoji} {issue.title} by {issue.user.login} "
                         f"({issue.repo}#{issue.number}, {issue.state})")

    def handle_update(self) -> api.Reply:
        """Pull the backup directory."""
        if time.time() - self.last_update < 60:
            return api.Reply("Not updating yet, try again later")
        self.last_update = time.time()
        output = subprocess.run(  # nosec
            ["git", "pull", "--rebase"],
            cwd=self.path,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
        ).stdout.decode().split("\n")[0]
        self._clear_cache()
        return api.Reply(output)

    def _clear_cache(self) -> None:
        """Clear the memoization cache."""
        for func in (self.load_issue, self.issues, self.repos):
            func.cache_clear()

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
        if os.path.exists(issues_path):
            issues.extend(
                IssuePath(
                    os.path.join(issues_path, issue),
                    repo,
                    int(issue.removesuffix(".json")),
                    is_pull_request=False,
                ) for issue in os.listdir(issues_path))

        pulls_path = os.path.join(repo.path, "pulls")
        if os.path.exists(pulls_path):
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
    github_path = os.path.join(api.BUILD_WORKSPACE_DIRECTORY, "tools", "backup")

    gh = GitHub(github_path)
    reply = gh.handle_cli(tuple(sys.argv[1:]))
    if reply is not None:
        print(reply.text)

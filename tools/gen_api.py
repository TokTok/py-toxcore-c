#!/usr/bin/env python3

import os.path
import sys
from typing import Iterable, List, Sequence, Tuple


def tokenize(line: str) -> Tuple[str, ...]:
    tokens = []
    token = ""
    for c in line:
        if c == " ":
            if token:
                tokens.append(token)
                token = ""
            continue

        if c in "(),{};[]*":
            if token:
                tokens.append(token)
                token = ""
            tokens.append(c)
            continue

        token += c
    if token:
        tokens.append(token)
    return tuple(tokens)


def needs_space(l: str, r: str) -> bool:
    return l.isidentifier() and r.isidentifier() or l in ",*"


def untokenize(tokens: Tuple[str, ...]) -> str:
    line = []
    for i in range(len(tokens) - 1):
        if tokens[i : i + 2] == ("void", ")"):
            break
        line.append(tokens[i])
        if needs_space(tokens[i], tokens[i + 1]):
            # print(f"'{tokens[i]}' and '{tokens[i + 1]}' need space")
            line.append(" ")
    line.append(tokens[-1])
    return "".join(line)


def cythonify_tokens(tokens: Iterable[str]) -> Tuple[str, ...]:
    return tuple(t for t in tokens if t not in ("struct", ";"))


def untokenize_fun(tokens: Iterable[str]) -> str:
    return untokenize(cythonify_tokens(tokens))


def token_before(token: str, tokens: Tuple[str, ...]) -> str:
    for i in range(len(tokens)):
        if i > 0 and tokens[i] == token:
            return tokens[i - 1]
    return ""


def parse_params(tokens: Tuple[str, ...]) -> List[Tuple[List[str], str]]:
    params: List[Tuple[List[str], str]] = []
    for i in range(len(tokens) - 1):
        if tokens[i] in "(,":
            params.append(([], ""))
        elif tokens[i + 1] in ",)":
            params[-1] = (params[-1][0], tokens[i])
        else:
            params[-1][0].append(tokens[i])
    return params


def finalize_handler(
    type_prefix: str, handlers: List[str], event: str, params: List[str]
) -> None:
    handlers[-1] += ":"
    self = ""
    array = ""
    args = []
    for ty, arg in parse_params(cythonify_tokens(params)):
        if ty == ["uint8_t", "*"]:
            if arg == "public_key":
                args.append(f"{arg}[:tox_public_key_size()]")
            else:
                array = arg
            continue
        if array and ty == ["size_t"]:
            args.append(f"{array}[:{arg}]")
            array = ""
            continue
        if ty == ["Tox", "*"]:
            continue
        if len(ty) == 1 and ty[0].startswith(type_prefix):
            args.append(f"{ty[0]}({arg})")
        elif ty == ["void", "*"]:
            self = f"(<Core> {arg})"
        else:
            args.append(arg)
    handlers.append(f"    {self}.handle_{event}({', '.join(args)})")


def gen_cython(lines: Sequence[str], fun_prefix: str) -> List[str]:
    const_prefix = fun_prefix.upper()
    type_prefix = fun_prefix.capitalize()

    state = ["file"]

    extern = []
    handlers = []
    install_handlers = ["cdef void install_handlers(Tox *ptr):"]
    params = []
    event = ""

    extern.append('cdef extern from "tox/tox.h":')
    for line in lines:
        line = line.strip()
        tokens = tokenize(line)
        # print("-----")
        # print(str(state))
        # print(line)
        # print(str(tokens))
        if not any(tokens):
            continue

        if tokens[0] == "//!TOKSTYLE-":
            state.append("ignore")
            continue
        if tokens[0] == "//!TOKSTYLE+":
            state.pop()
            continue
        if state[-1] == "ignore":
            continue

        if tokens[0] == "}":
            state.pop()
            continue

        if tokens[0] == "#define":
            if tokens[-1] == "\\":
                state.append("macro")
            continue
        if state[-1] == "macro":
            if tokens[-1] != "\\":
                state.pop()
            continue

        if tokens[:2] == ("*", "::"):
            extern.append("")
            extern.append(f"    # {line[5:]}")

        # extern "C" {}
        if tokens == ("extern", '"C"', "{"):
            state.append("extern-c")

        # struct definitions (members are ignored)
        if tokens[0] == "struct" and tokens[-1] == "{":
            state.append("struct")
            extern.append("")
            extern.append(f"    cdef struct {tokens[1]}")

        # typedef struct Tox Tox;
        if tokens[:2] == ("typedef", "struct"):
            extern.append(f"    ctypedef struct {tokens[2]}")

        # enums
        if (tokens[:2] == ("typedef", "enum") or tokens[0] == "enum") and tokens[
            -1
        ] == "{":
            extern.append("")
            extern.append(f"    cpdef enum {tokens[-2]}:")
            state.append("enum")
        elif state[-1] == "enum" and tokens[0].startswith(const_prefix):
            extern.append(f"        {tokens[0]},")

        # functions and callbacks
        if (
            "(" in tokens
            and tokens[0].isidentifier()
            and token_before("(", tokens).startswith(fun_prefix)
            and tokens[0] != "typedef"
        ):
            extern.append(f"    cdef {untokenize_fun(tokens)}")
            if ";" not in tokens:
                state.append("fun")
            continue
        if tokens[:2] == ("typedef", "void"):
            extern.append(f"    c{untokenize_fun(tokens)}")

            event = tokens[2][len(fun_prefix) : -3]
            params = list(tokens[3:])

            # TODO(iphydf): Handle this better (by checking whether we have a callback install
            # function for this event).
            if event != "log":
                handlers.append(
                    f"cdef void handle_{untokenize_fun((event,) + tokens[3:])}"
                )
                install_handlers.append(
                    f"    {fun_prefix}callback_{event}(ptr, handle_{event})"
                )
            if ";" not in tokens:
                state.append("callback")
            else:
                if event != "log":
                    finalize_handler(type_prefix, handlers, event, params)
                params = []
                event = ""
            continue
        if state[-1] == "callback":
            if event != "log":
                handlers.append(f"    {untokenize_fun(tokens)}")
        if state[-1] in ("fun", "callback"):
            extern.append(f"        {untokenize_fun(tokens)}")
            params.extend(tokens)
            if ";" in tokens:
                if event:
                    if event != "log":
                        finalize_handler(type_prefix, handlers, event, params)
                    params = []
                    event = ""
                state.pop()

    return extern + [""] + handlers + [""] + install_handlers


def main() -> None:
    src = sys.argv[1]
    api = sys.argv[2]

    with open(src, "r") as src_fh:
        for line in src_fh.readlines():
            if line.startswith("cdef extern from"):
                with open(api, "r") as api_fh:
                    print(
                        "\n".join(
                            gen_cython(
                                api_fh.readlines(),
                                fun_prefix=os.path.split(api)[-1].split(".")[0] + "_",
                            )
                        )
                    )
            else:
                print(line.rstrip())


if __name__ == "__main__":
    main()

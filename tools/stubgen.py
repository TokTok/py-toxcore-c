import collections
import inspect
import os.path
import sys

import pytox.common
import pytox.toxav.toxav
import pytox.toxcore.tox
import pytox.toxencryptsave.toxencryptsave

PACKAGES = [
    pytox.toxav.toxav,
    pytox.toxcore.tox,
    pytox.toxencryptsave.toxencryptsave,
]


def process_class(name: str, cls: list[str], imports: set[str], attr: object) -> None:
    for mem in dir(attr):
        mem_attr = getattr(attr, mem)
        if (
            mem in ("__init__", "__enter__", "__exit__")
            or "cython_function_or_method" in mem_attr.__class__.__name__
        ):
            doc = mem_attr.__doc__.split("\n")[0]
            if " -> " not in doc:
                doc += " -> None"
            if " -> Self" in doc:
                imports.add("from typing import Self")
            if ": array" in doc:
                imports.add("from array import array")
                imports.add("from typing import Any")
                doc = doc.replace(": array", ": array[Any]")
            if ": Optional" in doc:
                imports.add("from typing import Optional")
            if ": TracebackType" in doc:
                imports.add("from types import TracebackType")
            if ": Tox_Ptr" in doc and attr.__module__ != "tox":
                imports.add("from pytox.toxcore.tox import Tox_Ptr")
            cls.append(f"    def {doc}: ...")
        elif mem_attr.__class__.__name__ == "getset_descriptor":
            imports.add("from typing import Any")
            cls.append(f"    {mem}: Any")
        else:
            if mem_attr.__doc__ and mem_attr.__doc__.startswith(mem):
                raise Exception((mem, mem_attr.__doc__, mem_attr.__class__))


def process_type(
    sym: str, attr: object, imports: set[str], classes: dict[str, list[str]]
) -> None:
    if not isinstance(attr, type):
        return

    superclass = inspect.getclasstree([attr])[-1][0][1][0]
    is_enum = False
    if attr.__class__.__name__ == "EnumType":
        imports.add("import enum")
        inherit = "(enum.Enum)"
        is_enum = True
    elif superclass.__name__ == "object":
        inherit = ""
    else:
        imports.add("import " + superclass.__module__)
        inherit = f"({superclass.__module__}.{superclass.__name__})"
    cls = classes[sym] = [
        f"class {sym}{inherit}:",
    ]
    if sym.endswith("Exception") or is_enum:
        cls[0] += " ..."
    else:
        process_class(sym, cls, imports, attr)


def process_value(
    sym: str, attr: object, consts: list[str], classes: dict[str, list[str]]
) -> None:
    if isinstance(attr, int):
        enum = tuple(c for c in classes.keys() if sym.startswith(c.upper()))
        if enum:
            consts.append(f"{sym}: {enum[0]}")
        else:
            consts.append(f"{sym}: int")
    elif isinstance(attr, str):
        consts.append(f"{sym}: str")
    elif isinstance(attr, type):
        pass  # already done above
    else:
        raise Exception(f"nope {sym}: {type(attr)}")


def process_package(out_dir: str, pkg: object, prefix: str, name: str) -> None:
    attrs: list[tuple[str, object]] = []
    for sym in dir(pkg):
        attr = getattr(pkg, sym)
        if sym.startswith("__"):
            continue
        if isinstance(attr, pytox.common.__class__):
            continue
        if hasattr(attr, "__module__") and f"{prefix}.{attr.__module__}" != name:
            continue
        attrs.append((sym, attr))

    consts: list[str] = []
    classes: collections.OrderedDict[str, list[str]] = collections.OrderedDict()
    imports: set[str] = set()
    missing: set[str] = {
        "Tox_Conference_Number",
        "Tox_Conference_Peer_Number",
        "Tox_File_Number",
        "Tox_Friend_Number",
        "Tox_Friend_Message_Id",
        "Tox_Group_Number",
        "Tox_Group_Peer_Number",
        "Tox_Group_Message_Id",
    }

    for sym, attr in attrs:
        process_type(sym, attr, imports, classes)

    for sym, attr in attrs:
        process_value(sym, attr, consts, classes)

    with open(os.path.join(out_dir, f"{name.replace('.', '/')}.pyi"), "w") as pyi:
        pyi.write(f"# {name}\n")
        for s in sorted(imports):
            pyi.write(s + "\n")
        for m in sorted(missing):
            pyi.write(f"class {m}: ...\n")
        for cls in classes.values():
            pyi.write("\n".join(cls) + "\n")
        for c in consts:
            pyi.write(c + "\n")


def main() -> None:
    out_dir = sys.argv[1]
    for pkg in PACKAGES:
        if not pkg.__package__:
            raise Exception(f"{pkg} has no __package__")
        process_package(out_dir, pkg, pkg.__package__, pkg.__name__)


if __name__ == "__main__":
    main()

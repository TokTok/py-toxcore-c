import collections
import inspect
import os

import pytox.common
import pytox.toxav.toxav
import pytox.toxcore.tox
import pytox.toxencryptsave.toxencryptsave

PACKAGES = [
    pytox.toxav.toxav,
    pytox.toxcore.tox,
    pytox.toxencryptsave.toxencryptsave,
]


def collect_imports(doc: str, imports: set[str], typevars: set[str],
                    attr: object) -> str:
    if " -> List" in doc:
        imports.add("from typing import List")
    if " -> Self" in doc:
        imports.add("from typing import Self")
    if " -> T" in doc:
        imports.add("from typing import TypeVar")
        typevars.add('T = TypeVar("T")')
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
    return doc


def process_class(cls: list[str], imports: set[str], typevars: set[str],
                  attr: object) -> None:
    for mem in dir(attr):
        mem_attr = getattr(attr, mem)
        if (mem in ("__init__", "__enter__", "__exit__")
                or "cython_function_or_method" in mem_attr.__class__.__name__):
            doc = mem_attr.__doc__
            if not doc:
                raise Exception(f"no doc for {mem_attr}")
            doc = doc.split("\n")[0]
            if " -> " not in doc:
                doc += " -> None"
            doc = collect_imports(doc, imports, typevars, attr)
            cls.append(f"    def {doc}: ...")
        elif mem_attr.__class__.__name__ == "getset_descriptor":
            cls.append(f"    {mem_attr.__doc__}")
        else:
            if mem_attr.__doc__ and mem_attr.__doc__.startswith(mem):
                raise Exception((mem, mem_attr.__doc__, mem_attr.__class__))


def process_type(
    sym: str,
    attr: object,
    imports: set[str],
    typevars: set[str],
    classes: dict[str, list[str]],
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
        process_class(cls, imports, typevars, attr)


def process_value(sym: str, attr: object, consts: list[str],
                  classes: dict[str, list[str]]) -> None:
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
    elif "cython_function_or_method" in attr.__class__.__name__:
        doc = attr.__doc__
        if not doc:
            raise Exception(f"no doc for {sym}")
        doc = doc.split("\n")[0]
        if " -> " not in doc:
            doc += " -> None"
        consts.append(f"def {doc}: ...")
    else:
        raise Exception(f"nope {sym}: {type(attr)}")


def process_package(out_dir: str, pkg: object, prefix: str, name: str) -> None:
    attrs: list[tuple[str, object]] = []
    for sym in dir(pkg):
        attr = getattr(pkg, sym)
        if sym.startswith("__"):
            continue
        if isinstance(attr, type(pytox.common)):
            continue
        if hasattr(attr,
                   "__module__") and f"{prefix}.{attr.__module__}" != name:
            continue
        attrs.append((sym, attr))

    consts: list[str] = []
    classes: collections.OrderedDict[str,
                                     list[str]] = collections.OrderedDict()
    imports: set[str] = set()
    typevars: set[str] = set()
    missing: set[str] = set()
    if name == "pytox.toxcore.tox":
        missing = {
            "Tox_Conference_Number",
            "Tox_Conference_Offline_Peer_Number",
            "Tox_Conference_Peer_Number",
            "Tox_File_Number",
            "Tox_Friend_Number",
            "Tox_Friend_Message_Id",
            "Tox_Group_Number",
            "Tox_Group_Peer_Number",
            "Tox_Group_Message_Id",
        }

    for sym, attr in attrs:
        process_type(sym, attr, imports, typevars, classes)

    for sym, attr in attrs:
        process_value(sym, attr, consts, classes)

    with open(os.path.join(out_dir, f"{name.replace('.', '/')}.pyi"),
              "w") as pyi:
        pyi.write(f"# {name}\n")
        for s in sorted(imports):
            pyi.write(s + "\n")
        for tv in sorted(typevars):
            pyi.write(tv + "\n")
        for m in sorted(missing):
            pyi.write(f"{m} = int\n")
        for cls in classes.values():
            pyi.write("\n".join(cls) + "\n")
        for c in consts:
            pyi.write(c + "\n")


def main() -> None:
    root = os.getenv("BUILD_WORKSPACE_DIRECTORY")
    if not root:
        raise Exception("no $BUILD_WORKSPACE_DIRECTORY")
    out_dir = os.path.join(root, "py_toxcore_c")
    for pkg in PACKAGES:
        if not pkg.__package__:
            raise Exception(f"{pkg} has no __package__")
        process_package(out_dir, pkg, pkg.__package__, pkg.__name__)


if __name__ == "__main__":
    main()

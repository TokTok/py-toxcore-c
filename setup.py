from distutils.core import Extension
from distutils.core import setup

libraries = [
    "toxcore",
]
cflags = [
    "-funsigned-char",
]

setup(
    name="py-toxcore-c",
    version="0.3.0",
    description="Python binding for Tox the skype replacement",
    author="Iphigenia Df",
    author_email="iphydf@gmail.com",
    url="http://github.com/TokTok/py-toxcore-c",
    license="GPL",
    ext_modules=[
        Extension(
            f"pytox.{mod}",
            [f"pytox/{mod}.c"],
            extra_compile_args=cflags,
            libraries=libraries,
        ) for mod in (
            "av",
            "core",
            "error",
            "log",
            "memory",
            "network",
            "options",
            "random",
            "system",
            "time",
        )
    ],
)

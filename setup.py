from setuptools import Extension
from setuptools import setup

libraries = [
    "toxcore",
]
cflags = [
    "-funsigned-char",
]

setup(
    name="py-toxcore-c",
    version="0.2.19",
    description="Python binding for Tox the skype replacement",
    author="Iphigenia Df",
    author_email="iphydf@gmail.com",
    url="http://github.com/TokTok/py-toxcore-c",
    license="GPL",
    py_modules=["pytox.common"],
    ext_modules=[
        Extension(
            "pytox.toxav.toxav",
            ["pytox/toxav/toxav.c"],
            extra_compile_args=cflags,
            libraries=libraries,
        ),
        Extension(
            "pytox.toxcore.tox",
            ["pytox/toxcore/tox.c"],
            extra_compile_args=cflags,
            libraries=libraries,
        ),
        Extension(
            "pytox.toxencryptsave.toxencryptsave",
            ["pytox/toxencryptsave/toxencryptsave.c"],
            extra_compile_args=cflags,
            libraries=libraries,
        ),
    ],
)

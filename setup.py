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
            "pytox.av", ["pytox/av.c"], extra_compile_args=cflags, libraries=libraries
        ),
        Extension(
            "pytox.core",
            ["pytox/core.c"],
            extra_compile_args=cflags,
            libraries=libraries,
        ),
    ],
)

# cython: language_level=3

from pytox.toxcore import tox

def foo() -> str:
    tox.VERSION

import os

from distutils.core import setup, Extension

def supports_av():
    os.system("""
    echo 'extern int toxav_new(); int (*x)() = &toxav_new; int main(){}' \\
      | cc $LDFLAGS -xc - -ltoxcore \\
      > /dev/null 2>&1
    """)
    if os.path.exists("a.out"):
        os.remove("a.out")
        return True
    return False

sources = ["pytox/pytox.c", "pytox/core.c", "pytox/util.c"]
libraries = [
  "opus",
  "sodium",
  "toxcore",
  "vpx",
]
cflags = [
  "-Wall",
  # "-Werror",
  "-Wextra",
  "-Wno-declaration-after-statement",
  "-Wno-missing-field-initializers",
  "-Wno-unused-parameter",
  "-fno-strict-aliasing",
]

if supports_av():
    sources.append("pytox/av.c")
    cflags.append("-DENABLE_AV")
else:
    print("Warning: AV support not found, disabled.")

setup(
    name="PyTox",
    version="0.2.0",
    description="Python binding for Tox the skype replacement",
    author="Wei-Ning Huang (AZ)",
    author_email="aitjcize@gmail.com",
    url="http://github.com/TokTok/py-toxcore-c",
    license="GPL",
    ext_modules=[
        Extension(
            "pytox",
            sources,
            extra_compile_args=cflags,
            libraries=libraries
        )
    ]
)

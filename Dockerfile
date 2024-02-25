FROM alpine:3.19.0

RUN ["apk", "add", \
 "cmake", \
 "g++", \
 "gcc", \
 "git", \
 "libsodium-dev", \
 "libvpx-dev", \
 "linux-headers", \
 "opus-dev", \
 "pkgconfig", \
 "py3-pip", \
 "python3", \
 "python3-dev", \
 "samurai"]
RUN ["python3", "-m", "venv", "/path/to/venv"]

RUN . /path/to/venv/bin/activate \
 && pip3 install --no-cache-dir coverage cython cython-lint mypy

WORKDIR /build
RUN git clone --depth=1 --recursive https://github.com/TokTok/c-toxcore /build/c-toxcore \
 && cmake -GNinja -B/build/c-toxcore/_build -H/build/c-toxcore \
 -DBOOTSTRAP_DAEMON=OFF \
 -DENABLE_STATIC=OFF \
 -DMUST_BUILD_TOXAV=ON \
 && cmake --build /build/c-toxcore/_build --target install

COPY pytox /build/pytox

RUN . /path/to/venv/bin/activate \
 && cython-lint --max-line-length 300 $(find pytox -name "*.pyx" -or -name "*.pxd") \
 && cython -I. $(find pytox -name "*.pyx")

COPY setup.py /build/
ENV CFLAGS="-DCYTHON_TRACE=1 -O0"
RUN . /path/to/venv/bin/activate \
 && pip install . \
 && python3 -c 'import pytox.toxcore.tox as core; print(core.Tox_Ptr.__init__.__doc__)'

COPY .coveragerc /build/
COPY test /build/test
RUN . /path/to/venv/bin/activate \
 && coverage run -m unittest discover -v -p "*_test.py"
RUN . /path/to/venv/bin/activate \
 && coverage report

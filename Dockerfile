FROM ubuntu:22.04
LABEL maintainer="iphydf@gmail.com"

RUN apt-get update \
 && DEBIAN_FRONTEND="noninteractive" apt-get install --no-install-recommends -y \
 ca-certificates \
 cmake \
 gcc \
 g++ \
 git \
 libopus-dev \
 libsodium-dev \
 libvpx-dev \
 ninja-build \
 pkg-config \
 python3 \
 python3-dev \
 python3-pip \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && pip3 install --no-cache-dir cython cython-lint mypy

WORKDIR /build
RUN git clone --depth=1 --recursive https://github.com/TokTok/c-toxcore /build/c-toxcore \
 && cmake -GNinja -B/build/c-toxcore/_build -H/build/c-toxcore \
 -DBOOTSTRAP_DAEMON=OFF \
 -DENABLE_STATIC=OFF \
 -DMUST_BUILD_TOXAV=ON \
 && cmake --build /build/c-toxcore/_build --target install --parallel "$(nproc)" \
 && ldconfig

COPY pytox /build/pytox

RUN cython-lint --max-line-length 300 $(find pytox -name "*.pyx" -or -name "*.pxd")
RUN cython -I. $(find pytox -name "*.pyx")

COPY setup.py /build/
RUN python3 setup.py install \
 && python3 -c 'import pytox.toxcore.tox as core; print(core.__doc__)'

COPY test /build/test
RUN python3 test/tox_test.py

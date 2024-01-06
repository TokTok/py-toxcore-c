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
 && pip3 install cython mypy

WORKDIR /build
RUN git clone --depth=1 --recursive https://github.com/TokTok/c-toxcore /build/c-toxcore \
 && cmake -GNinja -B/build/c-toxcore/_build -H/build/c-toxcore \
 -DBOOTSTRAP_DAEMON=OFF \
 -DENABLE_STATIC=OFF \
 -DMUST_BUILD_TOXAV=ON \
 && cmake --build /build/c-toxcore/_build --target install --parallel "$(nproc)" \
 && ldconfig

COPY pytox /build/pytox

RUN cython pytox/toxav/toxav.pyx pytox/toxcore/tox.pyx pytox/toxencryptsave/toxencryptsave.pyx

COPY setup.py /build/
RUN python3 setup.py install \
 && python3 -c 'from pytox import core; print(core.__doc__)'

COPY test /build/test
RUN python3 test/core_test.py

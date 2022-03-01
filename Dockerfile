FROM ubuntu:20.04
LABEL maintainer="iphydf@gmail.com"

RUN apt-get update \
 && DEBIAN_FRONTEND="noninteractive" apt-get install --no-install-recommends -y \
 ca-certificates \
 cmake \
 cython \
 gcc \
 g++ \
 git \
 libopus-dev \
 libsodium-dev \
 libvpx-dev \
 libmsgpack-dev \
 ninja-build \
 pkg-config \
 python3 \
 python3-dev \
 python3-pip \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && pip3 install mypy

WORKDIR /build
RUN git clone --depth=1 https://github.com/TokTok/c-toxcore /build/c-toxcore \
 && cmake -GNinja -B/build/c-toxcore/_build -H/build/c-toxcore \
 -DBOOTSTRAP_DAEMON=OFF \
 -DENABLE_STATIC=OFF \
 -DMUST_BUILD_TOXAV=ON \
 && cmake --build /build/c-toxcore/_build --target install --parallel "$(nproc)" \
 && ldconfig

COPY pytox /build/pytox
COPY tools /build/tools

RUN mypy --strict tools/gen_api.py \
 && tools/gen_api.py pytox/src/core.pyx /usr/local/include/tox/tox.h > pytox/core.pyx \
 && cython pytox/av.pyx pytox/core.pyx

COPY setup.py /build/
RUN python3 setup.py install \
 && python3 -c 'from pytox import core; print(core.__doc__)'

COPY test /build/test
RUN python3 test/core_test.py

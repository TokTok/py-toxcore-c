FROM ubuntu:22.04
LABEL maintainer="iphydf@gmail.com"

RUN apt-get update \
 && DEBIAN_FRONTEND="noninteractive" apt-get install --no-install-recommends -y \
 ca-certificates \
 cmake \
 cython3 \
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
 && pip3 install mypy

WORKDIR /build
RUN git clone --recursive --depth=1 --branch=system https://github.com/iphydf/c-toxcore /build/c-toxcore \
 && cmake -GNinja -B/build/c-toxcore/_build -H/build/c-toxcore \
 -DBOOTSTRAP_DAEMON=OFF \
 -DENABLE_STATIC=OFF \
 -DMUST_BUILD_TOXAV=ON \
 && cmake --build /build/c-toxcore/_build --target install --parallel "$(nproc)" \
 && ldconfig && echo 0

# Tools first, they change less.
COPY tools /build/tools
COPY pytox.pxd /build/
COPY pytox /build/pytox

RUN mypy --strict tools/gen_api.py \
 && tools/gen_api.py pytox/src/core.pyx /usr/local/include > pytox/core.pyx \
 && tools/gen_api.py pytox/src/log.pxd /usr/local/include > pytox/log.pxd \
 && tools/gen_api.py pytox/src/log.pyx /usr/local/include > pytox/log.pyx \
 && tools/gen_api.py pytox/src/memory.pxd /usr/local/include > pytox/memory.pxd \
 && tools/gen_api.py pytox/src/memory.pyx /usr/local/include > pytox/memory.pyx \
 && tools/gen_api.py pytox/src/network.pxd /usr/local/include > pytox/network.pxd \
 && tools/gen_api.py pytox/src/network.pyx /usr/local/include > pytox/network.pyx \
 && tools/gen_api.py pytox/src/options.pxd /usr/local/include > pytox/options.pxd \
 && tools/gen_api.py pytox/src/options.pyx /usr/local/include > pytox/options.pyx \
 && tools/gen_api.py pytox/src/system.pxd /usr/local/include > pytox/system.pxd \
 && tools/gen_api.py pytox/src/system.pyx /usr/local/include > pytox/system.pyx \
 && tools/gen_api.py pytox/src/time.pxd /usr/local/include > pytox/time.pxd \
 && tools/gen_api.py pytox/src/time.pyx /usr/local/include > pytox/time.pyx \
 && cat pytox/options.pxd && cython3 -I $PWD -X "language_level=3" --line-directives pytox/av.pyx pytox/core.pyx \
      pytox/log.pyx \
      pytox/memory.pyx \
      pytox/network.pyx \
      pytox/options.pyx \
      pytox/system.pyx \
      pytox/time.pyx

COPY setup.py /build/
RUN python3 setup.py install \
 && python3 -c 'from pytox import core; print(core.__doc__)'

COPY test /build/test
RUN python3 test/core_test.py

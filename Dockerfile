FROM ubuntu:16.04
MAINTAINER iphydf@gmail.com

RUN apt-get update \
 && apt-get install --no-install-recommends -y ca-certificates cmake gcc g++ git libopus-dev libsodium-dev libvpx-dev pkg-config python-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

COPY pytox.ld setup.py /build/
COPY pytox /build/pytox/

WORKDIR /build
RUN git clone https://github.com/TokTok/c-toxcore /build/c-toxcore \
 && cmake -B/build/c-toxcore/_build -H/build/c-toxcore -DBOOTSTRAP_DAEMON=OFF \
 && make -C/build/c-toxcore/_build install -j"$(nproc)" \
 && python setup.py install \
 && rm -r /build/*

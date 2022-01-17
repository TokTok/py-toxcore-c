FROM ubuntu:20.04
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
 && pip3 install mypy

WORKDIR /build
RUN git clone --depth=1 https://github.com/TokTok/c-toxcore /build/c-toxcore \
 && cmake -GNinja -B/build/c-toxcore/_build -H/build/c-toxcore \
 -DBOOTSTRAP_DAEMON=OFF \
 -DENABLE_STATIC=OFF \
 -DMUST_BUILD_TOXAV=ON \
 && cmake --build /build/c-toxcore/_build --target install --parallel "$(nproc)" \
 && ldconfig

#COPY pytox.ld setup.py /build/
#COPY pytox /build/pytox/

#RUN python3 setup.py install \
 #&& rm -rf /build/* \
 #&& python3 -c 'import pytox; print(pytox.__doc__)'

#COPY tools /build/tools
#RUN mypy --strict tools/apicomplete \
 #&& tools/make_savefile echobot.tox

#COPY examples /build
#RUN ./echobot echobot.tox
##RUN mypy --strict examples/echobot

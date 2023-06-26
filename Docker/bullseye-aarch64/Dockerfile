# Copyright (c) 2020 SUSE LLC
# SPDX-License-Identifier: GPL-2.0-or-later

FROM debian:bullseye
RUN dpkg --add-architecture arm64
RUN sed -i '/deb/{p;s/^deb/deb-src/;}' /etc/apt/sources.list
RUN apt-get update
RUN apt-get build-dep --yes -a arm64 multipath-tools
RUN apt-get install --yes \
	gcc-aarch64-linux-gnu \
	libjson-c-dev:arm64 \
	libcmocka-dev:arm64 \
	libedit-dev:arm64
RUN apt-get clean
VOLUME /build
WORKDIR /build
ENV LD=aarch64-linux-gnu-ld
ENV CC=aarch64-linux-gnu-gcc
ENV PKG_CONFIG=aarch64-linux-gnu-pkg-config
ENTRYPOINT ["make"]

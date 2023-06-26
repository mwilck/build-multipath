# Copyright (c) 2020 SUSE LLC
# SPDX-License-Identifier: GPL-2.0-or-later

FROM debian:bullseye
RUN dpkg --add-architecture s390x
RUN sed -i '/deb/{p;s/^deb/deb-src/;}' /etc/apt/sources.list
RUN apt-get update
RUN apt-get build-dep --yes -a s390x multipath-tools
RUN apt-get install --yes \
	gcc-s390x-linux-gnu \
	libjson-c-dev:s390x \
	libedit-dev:s390x \
	libcmocka-dev:s390x
RUN apt-get clean
VOLUME /build
WORKDIR /build
ENV LD=s390x-linux-gnu-ld
ENV CC=s390x-linux-gnu-gcc
ENV PKG_CONFIG=s390x-linux-gnu-pkg-config
ENTRYPOINT ["make"]

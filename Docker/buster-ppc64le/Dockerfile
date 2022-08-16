# Copyright (c) 2020 SUSE LLC
# SPDX-License-Identifier: GPL-2.0-or-later

FROM debian:buster
RUN dpkg --add-architecture ppc64el
RUN sed -i '/deb/{p;s/^deb/deb-src/;}' /etc/apt/sources.list
RUN apt-get update
RUN apt-get build-dep --yes -a ppc64el multipath-tools
RUN apt-get install --yes \
	gcc-powerpc64le-linux-gnu \
	libjson-c-dev:ppc64el \
	libedit-dev:ppc64el \
	libcmocka-dev:ppc64el
RUN apt-get clean
VOLUME /build
WORKDIR /build
ENV LD=powerpc64le-linux-gnu-ld
ENV CC=powerpc64le-linux-gnu-gcc
ENV PKGCONFIG=powerpc64le-linux-gnu-pkg-config
ENTRYPOINT ["make"]

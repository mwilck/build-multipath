# Copyright (c) 2020 SUSE LLC
# SPDX-License-Identifier: GPL-2.0-or-later

FROM i386/debian:jessie
RUN apt-get update
RUN apt-get install --yes \
    	    gcc make perl-base pkg-config \
    	    libdevmapper-dev \
	    libreadline-dev \
	    libaio-dev \
	    libudev-dev \
	    libjson-c-dev \
	    liburcu-dev
RUN apt-get install --yes \
    	    libsystemd-dev
VOLUME /build

# The native version of cmocka is too old in jessie
RUN apt-get install --yes wget xz-utils cmake

WORKDIR /tmp
RUN wget -q https://cmocka.org/files/1.0/cmocka-1.0.1.tar.xz
RUN tar xfJ cmocka-1.0.1.tar.xz

WORKDIR /tmp/cmocka-1.0.1
RUN mkdir build
RUN rm -f CMakeCache.txt
WORKDIR /tmp/cmocka-1.0.1/build

RUN cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release ..
RUN make
RUN make install
# Clean up
RUN apt-get remove --yes cmake wget xz-utils
RUN apt-get autoremove --yes
RUN rm -rf /tmp/cmocka*

RUN apt-get clean
WORKDIR /build
ENTRYPOINT ["make"]

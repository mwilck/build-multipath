# Copyright (c) 2020 SUSE LLC
# SPDX-License-Identifier: GPL-2.0-or-later

FROM debian:sid
RUN apt-get update
RUN apt-get install --yes -o APT::Immediate-Configure=0 \
    	    gcc clang make pkg-config \
    	    libdevmapper-dev \
	    libreadline-dev \
	    libaio-dev \
	    libudev-dev \
	    libjson-c-dev \
	    liburcu-dev \
	    libedit-dev \
	    libcmocka-dev
RUN apt-get clean
VOLUME /build
WORKDIR /build
ENTRYPOINT ["make"]

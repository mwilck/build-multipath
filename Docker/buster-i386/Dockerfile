# Copyright (c) 2020 SUSE LLC
# SPDX-License-Identifier: GPL-2.0-or-later

FROM i386/debian:buster
RUN apt-get update
RUN apt-get install --yes \
    	    gcc make perl-base pkg-config \
    	    libdevmapper-dev \
	    libreadline-dev \
	    libaio-dev \
	    libudev-dev \
	    libjson-c-dev \
	    liburcu-dev \
	    libcmocka-dev
RUN apt-get clean
VOLUME /build
WORKDIR /build
ENTRYPOINT ["make"]

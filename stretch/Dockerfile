# Copyright (c) 2020 SUSE LLC
# SPDX-License-Identifier: GPL-2.0-or-later

FROM debian:stretch
RUN apt-get update && \
    apt-get install --yes gcc make perl-base pkg-config \
    	    libdevmapper-dev libreadline-dev libaio-dev \
	    libudev-dev libjson-c-dev liburcu-dev libcmocka-dev && \
    apt-get clean
VOLUME /build
WORKDIR /build
ENTRYPOINT ["make"]

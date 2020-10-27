# Copyright (c) 2020 SUSE LLC
# SPDX-License-Identifier: GPL-2.0-or-later

FROM debian:jessie
RUN apt-get update && \
    apt-get install --yes gcc make perl-base \
    	    libdevmapper-dev libreadline-dev libaio-dev libudev-dev libjson-c-dev liburcu-dev
VOLUME /build
WORKDIR /build
ENTRYPOINT ["make"]

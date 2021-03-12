# Copyright (c) 2020 SUSE LLC
# SPDX-License-Identifier: GPL-2.0-or-later

FROM opensuse/tumbleweed:latest
RUN zypper -n --gpg-auto-import-keys \
     install --no-recommends \
    	   make gcc11 perl-base \
	   gzip gawk \
	   libaio-devel \
	   device-mapper-devel \
	   libjson-c-devel \
	   libudev-devel \
	   liburcu-devel \
	   readline-devel \
	   systemd-devel \
	   libcmocka-devel
	   
VOLUME /build
WORKDIR /build
ENV CC=gcc-11
ENTRYPOINT ["make"]

# Copyright (c) 2020 SUSE LLC
# SPDX-License-Identifier: GPL-2.0-or-later

FROM opensuse/leap:15.3
RUN zypper -n --gpg-auto-import-keys \
     install --no-recommends \
    	   make gcc \
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
ENTRYPOINT ["make"]

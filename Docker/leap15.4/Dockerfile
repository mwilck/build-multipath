# Copyright (c) 2020 SUSE LLC
# SPDX-License-Identifier: GPL-2.0-or-later

FROM opensuse/leap:15.4
RUN zypper -n --gpg-auto-import-keys \
     install --no-recommends \
    	   make gcc \
	   gzip gawk \
	   libaio-devel \
	   device-mapper-devel \
	   libjson-c-devel \
	   liburcu-devel \
	   readline-devel \
	   systemd-devel \
	   libedit-devel \
	   libcmocka-devel

RUN zypper -n --gpg-auto-import-keys \
     install --no-recommends \
     strace
VOLUME /build
WORKDIR /build
ENTRYPOINT ["make"]

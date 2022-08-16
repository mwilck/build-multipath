# syntax = docker/dockerfile:experimental

# Copyright (c) 2020 SUSE LLC
# SPDX-License-Identifier: GPL-2.0-or-later

FROM registry.suse.com/suse/sle15:15.4.27.8.1
ARG ADDITIONAL_MODULES=sle-module-development-tools,PackageHub

# Copy /etc/zypp/credentials.d/SCCcredentials and /etc/SUSEConnect
# from a properly registered SLE system to this directory.
# On a registered SLE host, you can simply copy/link the host's files.
# The registered system must have the ADDITIONAL_MODULES above activated.
# See https://github.com/SUSE/container-suseconnect for more information.
RUN --mount=type=secret,id=SUSEConnect,required \
    --mount=type=secret,id=SCCcredentials,required \
     zypper -n --gpg-auto-import-keys \
     install --no-recommends \
    	   make gcc \
	   gzip gawk \
	   libaio-devel \
	   device-mapper-devel \
	   libjson-c-devel \
	   liburcu-devel \
	   readline-devel \
	   libedit-devel \
	   systemd-devel \
	   libcmocka-devel
	   
VOLUME /build
WORKDIR /build
ENTRYPOINT ["make"]

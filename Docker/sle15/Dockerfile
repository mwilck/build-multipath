# syntax = docker/dockerfile:experimental
# Copyright (c) 2022 SUSE LLC
# SPDX-License-Identifier: GPL-2.0-or-later
FROM registry.suse.com/suse/sle15:15.3
LABEL org.opencontainers.image.title="build-multipath-tools"
LABEL org.opencontainers.image.description="container for building multipath-tools on sles/15"
ARG ADDITIONAL_MODULES=sle-module-development-tools,PackageHub
RUN --mount=type=secret,id=SUSEConnect --mount=type=secret,id=SCCcredentials  \
    zypper -n --gpg-auto-import-keys ref
RUN --mount=type=secret,id=SUSEConnect --mount=type=secret,id=SCCcredentials  \
    zypper -n --gpg-auto-import-keys install --no-recommends --force-resolution --allow-downgrade \
    make gcc clang7 pkg-config gzip gawk \
    device-mapper-devel libaio-devel systemd-devel libjson-c-devel liburcu-devel readline-devel libedit-devel libmount-devel libcmocka-devel  
VOLUME /build
RUN --mount=type=secret,id=SUSEConnect --mount=type=secret,id=SCCcredentials  \
    zypper clean --all
WORKDIR /build

ENTRYPOINT ["make"]

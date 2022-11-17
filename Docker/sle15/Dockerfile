# syntax = docker/dockerfile:experimental
# Copyright (c) 2022 SUSE LLC
# SPDX-License-Identifier: GPL-2.0-or-later
FROM registry.suse.com/suse/sle15:15.0
LABEL org.opencontainers.image.title="build-multipath-tools"
LABEL org.opencontainers.image.description="container for building multipath-tools on sles/15"
ARG ADDITIONAL_MODULES=sle-module-development-tools,PackageHub
RUN --mount=type=secret,id=SUSEConnect --mount=type=secret,id=SCCcredentials  \
    zypper -n --gpg-auto-import-keys ref
RUN --mount=type=secret,id=SUSEConnect --mount=type=secret,id=SCCcredentials  \
    zypper -n --gpg-auto-import-keys install --no-recommends --force-resolution --allow-downgrade \
    make gcc clang5 pkg-config gzip gawk \
    device-mapper-devel libaio-devel systemd-devel libjson-c-devel liburcu-devel readline-devel libedit-devel libmount-devel  
VOLUME /build
RUN --mount=type=secret,id=SUSEConnect --mount=type=secret,id=SCCcredentials  \
    zypper -n --gpg-auto-import-keys install --no-recommends --force-resolution --allow-downgrade cmake wget tar xz
WORKDIR /tmp
RUN --mount=type=secret,id=SUSEConnect --mount=type=secret,id=SCCcredentials  \
    wget --no-check-certificate -q https://cmocka.org/files/1.1/cmocka-1.1.5.tar.xz
RUN --mount=type=secret,id=SUSEConnect --mount=type=secret,id=SCCcredentials  \
    tar xfJ cmocka-1.1.5.tar.xz && \
    mkdir -p cmocka-1.1.5/build && \
    rm -f cmocka-1.1.5/CMakeCache.txt
WORKDIR /tmp/cmocka-1.1.5/build
RUN --mount=type=secret,id=SUSEConnect --mount=type=secret,id=SCCcredentials  \
    cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release -DLIB_INSTALL_DIR:PATH=/usr/lib64 -DCMAKE_INSTALL_LIBDIR:PATH=/usr/lib64 ..
RUN --mount=type=secret,id=SUSEConnect --mount=type=secret,id=SCCcredentials  \
    make
RUN --mount=type=secret,id=SUSEConnect --mount=type=secret,id=SCCcredentials  \
    make install
RUN --mount=type=secret,id=SUSEConnect --mount=type=secret,id=SCCcredentials  \
    rm -rf /tmp/cmocka*
RUN --mount=type=secret,id=SUSEConnect --mount=type=secret,id=SCCcredentials  \
    zypper -n remove --clean-deps cmake wget tar xz
RUN --mount=type=secret,id=SUSEConnect --mount=type=secret,id=SCCcredentials  \
    zypper clean --all
WORKDIR /build

ENTRYPOINT ["make"]

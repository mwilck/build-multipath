# Copyright (c) 2020 SUSE LLC
# SPDX-License-Identifier: GPL-2.0-or-later

FROM fedora:rawhide
RUN dnf install -y \
    make clang gcc pkgconfig \
    libaio-devel \
    device-mapper-devel \
    libselinux-devel \
    libsepol-devel \
    readline-devel \
    ncurses-devel \
    userspace-rcu-devel \
    json-c-devel \
    libedit-devel \
    libcmocka-devel \
    musl-devel \
    musl-gcc
RUN yum clean all
RUN sed -i '/-isystem/s,$, -isystem /usr/include,' /usr/x86_64-linux-musl/lib64/musl-gcc.specs
VOLUME /build
WORKDIR /build
ENTRYPOINT ["make"]

# Copyright (c) 2020 SUSE LLC
# SPDX-License-Identifier: GPL-2.0-or-later

FROM fedora:34
RUN dnf install -y \
    make gcc clang pkgconfig \
    libaio-devel \
    device-mapper-devel \
    libselinux-devel \
    libsepol-devel \
    readline-devel \
    ncurses-devel \
    userspace-rcu-devel \
    json-c-devel \
    libedit-devel \
    libcmocka-devel
RUN yum clean all
VOLUME /build
WORKDIR /build
ENTRYPOINT ["make"]

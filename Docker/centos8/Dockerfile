# Copyright (c) 2020 SUSE LLC
# SPDX-License-Identifier: GPL-2.0-or-later

FROM centos:centos8
RUN dnf install -y \
    epel-release \
    'dnf-command(config-manager)'
RUN dnf config-manager --set-enabled powertools
RUN dnf install -y \
    make gcc pkgconfig \
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

# Copyright (c) 2020 SUSE LLC
# SPDX-License-Identifier: GPL-2.0-or-later

FROM centos:centos7
RUN yum install -y \
    epel-release
RUN yum install -y \
    make perl gcc pkgconfig \
    libaio-devel \
    device-mapper-devel \
    libselinux-devel \
    libsepol-devel \
    readline-devel \
    ncurses-devel \
    userspace-rcu-devel \
    json-c-devel \
    libcmocka-devel
RUN yum clean all
VOLUME /build
WORKDIR /build
ENTRYPOINT ["make"]

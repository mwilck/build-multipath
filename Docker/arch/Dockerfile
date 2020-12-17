# Copyright (c) 2020 SUSE LLC
# SPDX-License-Identifier: GPL-2.0-or-later

FROM archlinux:base
RUN pacman -Sy --noconfirm \
    make perl gcc pkgconfig \
    libaio \
    device-mapper \
    json-c \
    liburcu \
    systemd-libs \
    cmocka
VOLUME /build
WORKDIR /build
ENTRYPOINT ["make"]

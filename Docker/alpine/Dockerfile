# Copyright (c) 2020 SUSE LLC
# SPDX-License-Identifier: GPL-2.0-or-later

FROM alpine:latest
RUN apk add make gcc clang cmocka \
    musl-dev lvm2-dev libaio-dev readline-dev ncurses-dev eudev-dev \
    userspace-rcu-dev json-c-dev cmocka-dev
VOLUME /build
WORKDIR /build
ENTRYPOINT ["make"]

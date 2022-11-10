PREAMBLE
# Copyright (c) 2022 SUSE LLC
# SPDX-License-Identifier: GPL-2.0-or-later
FROM base
PREINSTALL
RUN RUN_ARGS \
    INSTALL \
    pkgs extra_pkgs \
    devel_pkgs
CLEAN
VOLUME /build
WORKDIR /build
ENVIRONMENT
ENTRYPOINT ["make"]

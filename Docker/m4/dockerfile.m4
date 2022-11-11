define(`RUN_CMD',`ifelse($1, `', ,
`RUN RUN_ARGS \
    $1')')
define(`WDIR', `WORKDIR $1')
define(`RUN_ARGS', `DF_RUN_ARGS')
divert`'dnl
PREAMBLE
# Copyright (c) 2022 SUSE LLC
# SPDX-License-Identifier: GPL-2.0-or-later
FROM BASE:TAG
PREINSTALL
RUN_CMD(UPDATE)
RUN_CMD(INSTALL \
    BUILD_PKGS \
    DEVEL_PKGS)
VOLUME /build
BUILD_CMOCKA
RUN_CMD(CLEAN)
WDIR(/build)
ENVIRONMENT
ENTRYPOINT ["make"]

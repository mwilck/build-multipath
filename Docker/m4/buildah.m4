define(`RUN_CMD',`ifelse($1, `', ,
`buildah run RUN_ARGS \
    "$work" \
    $1')')
define(`WDIR', `buildah config --workingdir $1 "$work"')
define(`RUN_ARGS', `BD_RUN_ARGS')
divert`'dnl
#! /bin/sh
# Copyright (c) 2022 SUSE LLC
# SPDX-License-Identifier: GPL-2.0-or-later
set -ex
work=$(buildah from $BUILD_OPTS "BASE:TAG")
trap 'buildah rm "$work"' 0
ifelse(decomma(PREINSTALL), `', , `patsubst(decomma(PREINSTALL), `ARG ', `buildah config --env ') "$work"')
RUN_CMD(UPDATE)
RUN_CMD(INSTALL \
    BUILD_PKGS \
    DEVEL_PKGS)
buildah config --volume /build "$work"
BUILD_CMOCKA
RUN_CMD(CLEAN)
WDIR(/build)
buildah config --env "ADDITIONAL_MODULES-" "$work"
buildah config --entrypoint '["make"]' "$work"
buildah config --cmd '[]' "$work"
ID=$(buildah commit "$work" "$NAME")
set +x
echo $ID

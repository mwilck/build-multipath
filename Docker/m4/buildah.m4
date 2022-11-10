# Copyright (c) 2022 SUSE LLC
# SPDX-License-Identifier: GPL-2.0-or-later
WORK=$(buildah from $BUILD_OPTS "base")
trap 'buildah rm "$WORK"' 0
ifelse(decomma(PREINSTALL), `', , `patsubst(decomma(PREINSTALL), `ARG ', `buildah config --env ') "$WORK"')
buildah run BUILDAH_RUN_ARGS  \
    "$WORK" \
    INSTALL \
    pkgs extra_pkgs \
    devel_pkgs
patsubst(CLEAN, `RUN ', `buildah run ') "$WORK"
buildah config --env "ADDITIONAL_MODULES-" "$WORK"
buildah config --volume /build "$WORK"
buildah config --workingdir /build "$WORK"
buildah config --entrypoint '[ "make" ]' "$WORK"
ID=$(buildah commit "$WORK" "$NAME")
echo $ID

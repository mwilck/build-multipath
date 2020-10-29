# syntax = docker/dockerfile:experimental

# Copyright (c) 2020 SUSE LLC
# SPDX-License-Identifier: GPL-2.0-or-later

FROM registry.suse.com/suse/sles12sp3
ARG ADDITIONAL_MODULES=

# Copy /etc/zypp/credentials.d/SCCcredentials and /etc/SUSEConnect
# from a properly registered SLE system to this directory.
# On a registered SLE host, you can simply copy/link the host's files.
# The registered system must have the ADDITIONAL_MODULES above activated.
# See https://github.com/SUSE/container-suseconnect for more information.
RUN --mount=type=secret,id=SUSEConnect,required \
    --mount=type=secret,id=SCCcredentials,required \
     zypper -n --gpg-auto-import-keys refs
RUN --mount=type=secret,id=SUSEConnect,required \
    --mount=type=secret,id=SCCcredentials,required \
     zypper -n --gpg-auto-import-keys ref
RUN --mount=type=secret,id=SUSEConnect,required \
    --mount=type=secret,id=SCCcredentials,required \
     zypper -n --gpg-auto-import-keys --no-refresh \
     install --no-recommends --oldpackage --force-resolution \
    	   make gcc perl-base

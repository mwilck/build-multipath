# syntax = docker/dockerfile:experimental

# Copyright (c) 2020 SUSE LLC
# SPDX-License-Identifier: GPL-2.0-or-later

FROM registry.suse.com/suse/sle15:15.0.4.10.13
ARG ADDITIONAL_MODULES=sle-module-development-tools,PackageHub

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
     zypper -n --gpg-auto-import-keys \
     install --no-recommends --allow-downgrade --force-resolution \
    	   make gcc \
	   gzip gawk \
	   libaio-devel \
	   device-mapper-devel \
	   libjson-c-devel \
	   libudev-devel \
	   liburcu-devel \
	   readline-devel \
	   libedit-devel \
	   systemd-devel

# cmocka is not available in SLE repositories

RUN --mount=type=secret,id=SUSEConnect,required \
    --mount=type=secret,id=SCCcredentials,required \
     zypper -n --gpg-auto-import-keys install --no-recommends \
     	    cmake wget tar xz

WORKDIR /tmp
RUN wget -q https://cmocka.org/files/1.1/cmocka-1.1.1.tar.xz
RUN tar xfvJ cmocka-1.1.1.tar.xz
WORKDIR /tmp/cmocka-1.1.1
RUN mkdir build
RUN rm -f CMakeCache.txt
WORKDIR /tmp/cmocka-1.1.1/build
RUN cmake -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DLIB_INSTALL_DIR:PATH=/usr/lib64 \
    -DCMAKE_INSTALL_LIBDIR:PATH=/usr/lib64 \
    ..
RUN make
RUN make install
RUN rm -rf cmocka*

RUN --mount=type=secret,id=SUSEConnect,required \
    --mount=type=secret,id=SCCcredentials,required \
     zypper -n remove \
     	    libmetalink3 librhash0 libuv1 libarchive13 libcares2 python3-base \
	    libpython3_6m1_0 python-rpm-macros \
	    cmake wget tar  xz
RUN --mount=type=secret,id=SUSEConnect,required \
    --mount=type=secret,id=SCCcredentials,required \
    RUN zypper clean -a

VOLUME /build
WORKDIR /build
ENTRYPOINT ["make"]

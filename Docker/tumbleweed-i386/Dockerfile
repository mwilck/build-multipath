# Copyright (c) 2020 SUSE LLC
# SPDX-License-Identifier: GPL-2.0-or-later


# The image must be pulled manually and retagged
# it will overwrite the amd64 image!
# podman pull --override-arch=386 opensuse/tumbleweed
# podman tag opensuse/tumbleweed i386/tumbleweed

FROM i386/tumbleweed:latest
RUN echo 'arch = i586' >>/etc/zypp/zypp.conf
RUN zypper -n --gpg-auto-import-keys \
     install --no-recommends \
    	   make gcc11 \
	   gzip gawk \
	   libaio-devel \
	   device-mapper-devel \
	   libjson-c-devel \
	   libudev-devel \
	   liburcu-devel \
	   readline-devel \
	   libedit-devel \
	   systemd-devel \
	   libcmocka-devel
	   
VOLUME /build
WORKDIR /build
ENTRYPOINT ["make"]

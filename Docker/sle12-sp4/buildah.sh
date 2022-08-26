#! /bin/bash
trap 'echo error in "$BASH_COMMAND" >&2; exit 1' ERR
NAME=$1
[[ $NAME && -f SUSEConnect && -f SCCcredentials ]]
BASE="registry.suse.com/suse/sles12sp4:26.4"
ADDONS="sle-sdk,PackageHub"
set -x
WORK=$(buildah from "$BASE")
echo working on "$WORK" >&2
buildah config --env "ADDITIONAL_MODULES=$ADDONS" "$WORK"
buildah  run --mount=type=bind,src=$PWD/SUSEConnect,dst=/run/secrets/SUSEConnect \
	 --mount=type=bind,src=$PWD/SCCcredentials,dst=/run/secrets/SCCcredentials \
	 "$WORK" \
	 zypper -n --gpg-auto-import-keys \
	 install --oldpackage --no-recommends \
		make gcc perl-base \
	   gzip gawk \
	   libaio-devel \
	   device-mapper-devel \
	   libjson-c-devel \
	   libudev-devel \
	   liburcu-devel \
	   readline-devel \
	   libedit-devel \
	   systemd-devel \
	   cmake wget tar xz

buildah config --env "ADDITIONAL_MODULES-" "$WORK"
buildah config --volume /build "$WORK"
buildah config --workingdir /build "$WORK"
buildah run "$WORK" wget -q https://cmocka.org/files/1.1/cmocka-1.1.5.tar.xz
buildah run "$WORK" tar xfvJ cmocka-1.1.5.tar.xz
buildah config --workingdir /build/cmocka-1.1.5/build "$WORK"
buildah run "$WORK" cmake -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DLIB_INSTALL_DIR:PATH=/usr/lib64 \
    -DCMAKE_INSTALL_LIBDIR:PATH=/usr/lib64 ..
buildah run "$WORK" make
buildah run "$WORK" make install
buildah config --workingdir /build "$WORK"
buildah run "$WORK" rm -rf cmocka-1.1.5.tar.xz cmocka-1.1.5
buildah run "$WORK" \
	 zypper -n --no-refresh --no-remote remove \
	 libidn11 libarchive13  \
	 libpython2_7-1_0 python-rpm-macros python-base \
	 cmake tar
buildah run "$WORK" zypper clean --all
buildah config --entrypoint '[ "make" ]' "$WORK"
ID=$(buildah commit "$WORK" "$NAME")
buildah rm "$WORK"
echo $ID

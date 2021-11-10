#! /bin/bash
trap 'echo error in "$BASH_COMMAND" >&2; exit 1' ERR
NAME=$1
[[ $NAME && -f SUSEConnect && -f SCCcredentials ]]
BASE="registry.suse.de/suse/sle-15-sp4/ga/images/suse/sle15:15.4"
ADDONS="sle-module-development-tools,PackageHub"
set -x
WORK=$(buildah from "$BASE")
echo working on "$WORK" >&2
buildah config --env "ADDITIONAL_MODULES=$ADDONS" "$WORK"
buildah  run --mount=type=bind,src=$PWD/SUSEConnect,dst=/run/secrets/SUSEConnect \
	 --mount=type=bind,src=$PWD/SCCcredentials,dst=/run/secrets/SCCcredentials \
	 "$WORK" \
	 zypper -n --gpg-auto-import-keys \
	 install --no-recommends --allow-downgrade \
		make gcc perl-base \
	   gzip gawk \
	   libaio-devel \
	   device-mapper-devel \
	   libjson-c-devel \
	   libudev-devel \
	   liburcu-devel \
	   readline-devel \
	   systemd-devel \
	   libcmocka-devel
buildah run "$WORK" zypper clean --all
buildah config --env "ADDITIONAL_MODULES-" "$WORK"
buildah config --volume /build "$WORK"
buildah config --workingdir /build "$WORK"
buildah config --entrypoint '[ "make" ]' "$WORK"
ID=$(buildah commit "$WORK" "$NAME")
buildah rm "$WORK"
echo $ID

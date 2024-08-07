define(`BASE', `debian')
include(`debian.m4')

define(`devext', `lib$1-dev:DEBARCH')
# The cross-compilation overrides packages as it uses "apt-get build-dep"
define(`build_pkgs', `gcc-ARCHPREFIX')
define(`dev_pkgs', `json-c edit cmocka mount')

define(`ADD_DEBSRC', `RUN sed -i ''`/deb/{p;s/^deb/deb-src/;}''` /etc/apt/sources.list')
define(`PREINSTALL',
`RUN dpkg --add-architecture DEBARCH
ADD_DEBSRC')

define(`UPDATE', `apt-get update && apt-get build-dep --yes -a DEBARCH DEBPKG')

define(`ENV_VARS', `LD=ARCHPREFIX-ld CC=ARCHPREFIX-gcc PKG_CONFIG=ARCHPREFIX-pkg-config')

# Architecture translations
ifdef(`ARCH', , `define(`ARCH', `arm64')')
define(`DEBARCH',
`ifelse(ARCH, `ppc64le', `ppc64el', `ARCH')')

define(`ARCHPREFIX',
`ifelse(ARCH, `ppc64le', `powerpc64le-linux-gnu',
	ARCH, `arm64', `aarch64-linux-gnu',
	ARCH, `s390x', `s390x-linux-gnu',
	ARCH, `armhf', `arm-linux-gnueabihf',
	`errprint(`Unsupported architecture ARCH
')m4exit')')

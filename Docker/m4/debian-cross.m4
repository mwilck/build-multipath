define(`debarch', `ppc64el')
define(`archprefix', `powerpc64le-linux-gnu')

define(`base', `debian:bullseye')
define(`devext', `lib$1-dev:debarch')

define(`PREINSTALL',
`RUN dpkg --add-architecture ppc64el
RUN sed -i ''`/deb/{p;s/^deb/deb-src/;}''` /etc/apt/sources.list')
define(`INSTALL', `apt-get update && apt-get build-dep --yes -a debarch multipath-tools && apt-get install --yes')
define(`CLEAN', `RUN apt-get `clean'')
define(`ENVIRONMENT',
`ENV LD=archprefix-ld
ENV CC=archprefix-gcc
ENV PKGCONFIG=archprefix-pkg-config')

define(`pkgs', `gcc-archprefix')
define(`dev_pkgs', `json-c edit cmocka mount')

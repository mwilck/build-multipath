include(`fedora.m4')
define(`DEFAULT_TAG', `9')
define(`BASE', `quay.io/centos/centos')
define(`DNF', `dnf')
define(`PREINSTALL',
`RUN DNF config-manager --set-enabled crb')
define(`devext',
`ifelse($1, pkgconf, ,
        `rename($1)-devel')')

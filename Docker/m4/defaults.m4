# Debian (buster) package names, except for pkg-config
define(`build_pkgs', `make gcc clang pkgconfig')
define(`extra_build', `')
# Debian (buster) package names, without "lib" prefix
define(`dev_pkgs', `devmapper aio udev json-c urcu readline edit mount cmocka')
define(`extra_dev', `')

define(`PACKAGE', `multipath-tools')
define(`PREAMBLE', `dnl')
define(`PREINSTALL', `')
define(`UPDATE', `')
define(`RUN_ARGS', `')
define(`CLEAN', `')
define(`ENVIRONMENT', `')

# Debian (buster) package names, except for pkg-config
define(`pkgs', `make gcc clang pkgconfig')
define(`extra_pkgs', `')
# Debian (buster) package names, without "lib" prefix
define(`dev_pkgs', `devmapper aio udev json-c urcu readline edit mount cmocka')
define(`extra_dev', `')

define(`PREAMBLE', `dnl')
define(`PREINSTALL', `')
define(`RUN_ARGS', `')
define(`CLEAN', `')
define(`ENVIRONMENT', `')

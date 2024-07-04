define(`DEBPKG', `multipath-tools')
define(`build_pkgs', `make gcc clang pkgconfig')
# Debian (buster) package names, without "lib" prefix
define(`dev_pkgs', `devmapper aio udev json-c urcu readline edit mount cmocka')
define(`RUNTIME_PKGS', `make')
define(`NEED_CMOCKA', `yes')
define(`entrypoint', `make')

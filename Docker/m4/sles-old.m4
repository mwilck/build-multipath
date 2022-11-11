include(`sles.m4')
ifdef(`SP', , `define(`SP', `sp5')')
define(`BASE', `suse/sles12`'SP')
define(`DEFAULT_TAG', `6.5.398')
define(`SLE_SDK', `sle-sdk')
define(`build_pkgs', patsubst(build_pkgs, ` clang', `'))
define(`dev_pkgs', patsubst(dev_pkgs, ` cmocka', `'))
define(`CMOCKA_VER', `1.1.5')
define(`CMOCKA_DEPS', `cmake wget tar')
define(`CMOCKA_DEFS', `-DLIB_INSTALL_DIR:PATH=/usr/lib64 -DCMAKE_INSTALL_LIBDIR:PATH=/usr/lib64')

# Older SLE needs udev-devel AND systemd-devel, newer has only systemd-devel
define(`extra_dev', `systemd')
# package renames
define(`rename',
`ifelse($1, `devmapper', `device-mapper',
        $1, `readline', `$1',
	$1, `systemd', `$1',
	`lib$1')')

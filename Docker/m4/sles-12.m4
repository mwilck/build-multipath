ifdef(`SP', , `define(`SP', `sp5')')
define(`BASE', `suse/sles12`'SP')
define(`DEFAULT_TAG', `6.5.398')
define(`INSTALL', `ZYPPER --no-refresh install --no-recommends --force-resolution')
define(`SLE_SDK', `sle-sdk')
define(`CMOCKA_DEPS', `cmake wget tar')
define(`build_pkgs', patsubst(build_pkgs, ` clang', `'))
ifelse(TYPE, `obs', , `include(`sles-buildx.m4')')
include(`sles-cmocka.m4')

# SLE12 needs udev-devel AND systemd-devel, newer has only systemd-devel
define(`extra_dev', `systemd')
# package renames
define(`rename',
`ifelse($1, `devmapper', `device-mapper',
        $1, `readline', `$1',
	$1, `systemd', `$1',
	`lib$1')')

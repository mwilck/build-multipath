define(`BASE', `opensuse/leap')
define(`DEFAULT_TAG', `15.4')
define(`devext', rename($1)-devel)
define(`UPDATE', `zypper -n --gpg-auto-import-keys ref')
define(`INSTALL', `zypper -n --gpg-auto-import-keys install --no-recommends')
define(`REMOVE', `zypper -n remove --clean-deps $1')
dnl define(`REMOVE', `zypper -n remove $1')
define(`CLEAN', `zypper clean --all')

# package renames
define(`rename',
`ifelse($1, `udev', `systemd',
        $1, `devmapper', `device-mapper',
        $1, `readline', `$1',
	`lib$1')')
define(`pkgconfig', `pkg-config')

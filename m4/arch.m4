define(`BASE',`archlinux')
define(`DEFAULT_RELEASE', `base')
define(`devext',
`ifelse($1, `curl4-openssl', `curl',
	$1, `dbus-1', `dbus',
	$1, `archive', `lib$1',
	$1, `cap-ng', `lib$1',
	`$1')')

define(`INSTALL', `pacman -Syu --noconfirm')

# package renames
define(`devmapper', `device-mapper')
define(`urcu', `liburcu')
define(`edit', `libedit')
define(`aio', `libaio')
define(`udev', `systemd-libs')
define(`mount', `util-linux-libs')
define(`gplusplus', `gcc')
define(`ssl', `openssl')
define(`py3setuptools', `python-setuptools')

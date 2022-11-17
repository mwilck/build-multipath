define(`BASE',`archlinux')
define(`DEFAULT_RELEASE', `base')
define(`devext', `$1')
define(`INSTALL', `pacman -Sy --noconfirm')

# package renames
define(`devmapper', `device-mapper')
define(`urcu', `liburcu')
define(`edit', `libedit')
define(`aio', `libaio')
define(`udev', `systemd-libs')
define(`mount', `util-linux-libs')

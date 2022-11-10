define(`base', `opensuse/leap:15.4')
define(`devext', rename($1)-devel)
define(`INSTALL', `zypper -n --gpg-auto-import-keys `install' --no-recommends')
define(`CLEAN', `RUN zypper `clean' --all')

# package renames
define(`rename',
`ifelse($1, `udev', `systemd',
        $1, `devmapper', `device-mapper',
        $1, `readline', `$1',
	`lib$1')')

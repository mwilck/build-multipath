define(`base', `fedora:36')
define(`devext', `rename($1)-devel')
define(`INSTALL', `dnf `install' -y')
define(`CLEAN', `RUN dnf `clean' all')

# extra packages
define(`extra_dev', `libselinux libsepol')

# package renames
define(`rename',
`ifelse($1, `udev', `systemd',
	$1, `devmapper', `device-mapper',
	$1, `urcu', `userspace-rcu',
	$1, `readline', `$1',
	`lib$1')')

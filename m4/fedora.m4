define(`devext', `rename($1)-devel')
define(`INSTALL', `DNF install -y')
define(`CLEAN', `DNF clean all')
define(`DEFAULT_RELEASE', `rawhide')
define(`DNF', `dnf')

# package renames
define(`rename',
`ifelse($1, `udev', `systemd',
	$1, `devmapper', `device-mapper',
	$1, `urcu', `userspace-rcu',
	$1, `readline', `$1',
	$1, `json-c', `$1',
	`lib$1')')

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
        $1, `ssl', `openssl',
	$1, `dbus-1', `dbus',
	$1, `keyutils', `$1-libs',
	$1, `pam', `$1',
	$1, `curl4-openssl', `libcurl',
	`lib$1')')
define(`gplusplus', `gcc-c++')
define(`py3setuptools', `python3-setuptools')

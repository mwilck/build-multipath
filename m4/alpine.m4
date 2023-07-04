define(`BASE', `alpine')
define(`devext', rename($1)-dev)
define(`INSTALL', `apk add')

# extra packages
define(`extra_dev', `musl')

# package renames
define(`devmapper', `lvm2')
define(`aio', `libaio')
define(`edit', `libedit')
define(`udev', `eudev')
define(`urcu', `userspace-rcu')
define(`mount', `util-linux')
define(`gplusplus', `g++')
define(`ssl', `openssl')
define(`py3setuptools', `py3-setuptools')

define(`rename',
`ifelse($1, `curl4-openssl', `curl',
        $1, `dbus-1', `dbus',
        $1, `pam', `linux-pam',
        $1, `archive', `lib$1',
        $1, `cap-ng', `lib$1',
        `$1')')

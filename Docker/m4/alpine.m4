define(`BASE', `alpine:latest')
define(`devext', `$1-dev')
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

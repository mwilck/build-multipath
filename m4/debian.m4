define(`DEFAULT_RELEASE', `bullseye')
define(`devext', `lib$1-dev')
define(`UPDATE', `apt-get update')
define(`INSTALL', `apt-get install --yes')
define(`REMOVE', `apt-get remove --yes $1 && apt-get autoremove --yes')
define(`CLEAN', `apt-get clean')

# package renames
define(`pkgconfig', `pkg-config')
define(`gplusplus', `g++')
define(`py3setuptools', `python3-setuptools')

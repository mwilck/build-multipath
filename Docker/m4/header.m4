divert(-1)
# The following macros can/should be set by the user via -D
ifdef(`PACKAGE', , `define(`PACKAGE', `multipath')')
ifdef(`DISTRO', , `define(`DISTRO', `debian')')
ifdef(`RELEASE', , `define(`RELEASE', `DEFAULT_RELEASE')')
ifdef(`TAG', , `define(`TAG', `DEFAULT_TAG')')
ifdef(`TYPE', , `define(`TYPE', `')')
# only needed for OBS builds
ifdef(`VERSION', , `define(`VERSION', `0.2')')

include(`macros.m4')
include(`defaults.m4')
include(PACKAGE`.m4')
include(DISTRO`.m4')
sinclude(DISTRO-RELEASE`.m4')
divert`'dnl

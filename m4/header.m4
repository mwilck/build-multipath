divert(-1)
# The following macros can/should be set by the user via -D
ifdef(`PACKAGE', , `define(`PACKAGE', `multipath')')
ifdef(`IMAGE_TITLE', , `define(`IMAGE_TITLE', `build-PACKAGE')')

# support DISTRO=sles-15-15.2 syntax, will be split into
# DISTRO=sles RELEASE=15 TAG=15.2
ifdef(`DISTRO',
  `ifdef(`RELEASE', ,
    `ifelse(regexp(DISTRO, `^[^-]+-.+$'), 0,
      `define(`RELEASE', patsubst(DISTRO, `^[^-]+-', `'))
       define(`DISTRO', patsubst(DISTRO, `-.+$', `'))')')',
  `define(`DISTRO', `debian')')

ifdef(`RELEASE',
  `ifdef(`TAG', ,
    `ifelse(regexp(RELEASE, `^[^-]+-.+$'), 0,
      `define(`TAG', patsubst(RELEASE, `^[^-]+-', `'))
       define(`RELEASE', patsubst(RELEASE, `-.+$', `'))')')',
  `define(`RELEASE', `DEFAULT_RELEASE')')

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

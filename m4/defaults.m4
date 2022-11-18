# Debian (buster) package names, except for pkg-config
define(`build_pkgs', `')
define(`extra_build', `')
# Debian (buster) package names, without "lib" prefix
define(`dev_pkgs', `')
define(`extra_dev', `')
# This must be defined by the distro and is only required
# for runtime environments
define(`libver', `errprint(`ERROR: libver is not set!
')m4exit(`1')')')

define(`PREAMBLE', `dnl')
define(`PREINSTALL', `dnl')
define(`UPDATE', `true')
define(`RUN_ARGS', `')
define(`CLEAN', `')
define(`ENV_VARS', `')
define(`BASE', `DISTRO')
define(`DEFAULT_RELEASE', `latest')
define(`DEFAULT_TAG', `RELEASE')
define(`LABEL_PREFIX', `dnl')
define(`EXTRA_LABELS', `dnl')
define(`LABEL_SUFFIX', `dnl')

define(`devext', rename($1)-devel)
define(`ZYPPER', `zypper --quiet --non-interactive --gpg-auto-import-keys')
define(`UPDATE', `ZYPPER refresh')
define(`INSTALL', `ZYPPER --no-refresh install --no-recommends --force-resolution --allow-downgrade')
define(`REMOVE', `ZYPPER remove --clean-deps $1')
define(`CLEAN', `ZYPPER clean --all')
define(`extra_build', `gzip gawk')

# package renames
define(`rename',
`ifelse($1, `udev', `systemd',
        $1, `devmapper', `device-mapper',
        $1, `readline', `$1',
        $1, `ssl', `openssl',
	$1, `dbus-1', `$1',
	$1, `keyutils', `$1',
	$1, `pam', `$1',
	$1, `curl4-openssl', `libcurl',
	`lib$1')')
define(`pkgconfig', `pkg-config')
define(`gplusplus', `gcc-c++')
define(`py3setuptools', `python3-setuptools')

# for OBS, provide labels
ifelse(TYPE, `obs',
`define(`PREAMBLE', ``#'!BuildTag: IMAGE_TITLE:latest IMAGE_TITLE:VERSION IMAGE_TITLE:VERSION.%`RELEASE'%')
define(`LABEL_PREFIX', ``#' labelprefix=org.opensuse.IMAGE_TITLE')
define(`EXTRA_LABELS',
`LABEL org.openbuildservice.disturl="%DISTURL%"
LABEL org.opencontainers.image.created="%BUILDTIME%"
LABEL org.opensuse.reference="OBS_REGISTRY/OBS_PRJ/OBS_REPO/IMAGE_TITLE:VERSION.%`RELEASE'%"')
define(`LABEL_SUFFIX', `# endlabelprefix')')

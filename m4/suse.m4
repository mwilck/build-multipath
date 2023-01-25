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
	`lib$1')')
define(`pkgconfig', `pkg-config')

# for OBS, provide labels
ifelse(TYPE, `obs',
`define(`PREAMBLE', ``#'!BuildTag: IMAGE_TITLE:latest IMAGE_TITLE:VERSION IMAGE_TITLE:VERSION.%`RELEASE'%')
define(`LABEL_PREFIX', ``#' labelprefix=org.opensuse.IMAGE_TITLE')
define(`EXTRA_LABELS',
`LABEL org.openbuildservice.disturl="%DISTURL%"
LABEL org.opencontainers.image.created="%BUILDTIME%"')
define(`LABEL_SUFFIX', `# endlabelprefix')')

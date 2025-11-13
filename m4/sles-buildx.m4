# special syntax (docker buildx) for passing credentials to SLE containers
define(`PREAMBLE', ``#' syntax = docker/dockerfile:experimental')
define(`PREINSTALL',`ARG ADDITIONAL_MODULES=ADDON_MODS')
define(`SECRETS', `SUSEConnect SCCcredentials')
define(`mountarg', `--mount=type=secret,id=$1')
define(`RUN_ARGS', `map_spc(`mountarg', SECRETS) \
   ')

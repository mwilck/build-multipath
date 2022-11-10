include(`leap.m4')
define(`base', `registry.suse.com/suse/sle15:ifdef(`version',`version',`15.4')')
define(`PREAMBLE',
`# syntax = docker/dockerfile:experimental')
define(`PREINSTALL',
`ARG ADDITIONAL_MODULES=sle-module-development-tools,PackageHub')
define(`SECRETS', `SUSEConnect SCCcredentials')
define(`mountarg', `--mount=type=secret,id=$1,required')
define(`RUN_ARGS', `map_spc(`mountarg', SECRETS)')
define(`BUILDAH_RUN_ARGS',
`patsubst(decomma(RUN_ARGS),
       `--mount=type=secret`,'id=\([a-zA-Z]*\)`,'required',
       `--mount=type=bind`,'src=$PWD/\1`,'dst=/run/secrets/\1')')

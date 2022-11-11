include(`leap.m4')
define(`BASE', `suse/sle15')
define(`PREAMBLE',
`# syntax = docker/dockerfile:experimental')
define(`SLE_SDK', `sle-module-development-tools')
define(`PREINSTALL',
`ARG ADDITIONAL_MODULES=SLE_SDK,PackageHub')
define(`SECRETS', `SUSEConnect SCCcredentials')
define(`mountarg', `--mount=type=secret,id=$1,required')
define(`DF_RUN_ARGS', `map_spc(`mountarg', SECRETS)')
define(`BD_RUN_ARGS',
`patsubst(decomma(DF_RUN_ARGS),
       `--mount=type=secret`,'id=\([a-zA-Z]*\)`,'required',
       `--mount=type=bind`,'src=$PWD/\1`,'dst=/run/secrets/\1')')

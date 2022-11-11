divert(-1)
include(`macros.m4')
include(`defaults.m4')
try_include(DISTRO`.m4')
ifdef(`BASE', , `define(`BASE', `DISTRO')')
ifdef(`DEFAULT_TAG', , `define(`DEFAULT_TAG', `latest')')
ifdef(`TAG', , `define(`TAG', `DEFAULT_TAG')')
define(`RUN_CMD',`ifelse($1, `', ,
`RUN RUN_ARGS \
    $1')')
define(`WDIR', `WORKDIR $1')
divert`'dnl

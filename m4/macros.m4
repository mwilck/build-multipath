# map operation on comma-separated list, ends up separated by $2
define(`map',
	`ifelse($#, 0, , $#, 1, , $#, 2, ,
	 $#, 3, `$1($3)$2',
	 `$1($3)$2map(`$1', `$2', shift(shift(shift($@))))')')

# Quote commas in a comma-separated list
# dnl decomma(a,b,c) -> a`,'b`,'c
# allows processing strings with commas:
# define(cc, `a,b')
# translit(cc, `,', ;) => a (+ warning excess args)
# translit(`cc', `,', ;) => a,b (translit does nothing -> cc -> a,b)
# translit(decomma(cc), `,', ;) => a;b
define(`decomma',
`ifelse($#, 0, , $#, 1, `$1', `$1``,''decomma(shift($@))')')

# map operation on space-separated list
define(`map_spc', `map(`$1', ` ', translit($2, ` ', `,'))')

define(`BUILD_PKGS', `build_pkgs extra_build ADD_PKGS')
define(`DEVEL_PKGS',
`map_spc(`devext', `dev_pkgs') ifelse(extra_dev, `', , map_spc(`devext', `extra_dev'))')
define(`_libver', lib`$1`'libver(`$1')')
define(`RUNTIME_LIBS', `map_spc(`_libver', `dev_pkgs')')

define(`RUN_CMD',`ifelse($1, `', ,
`RUN RUN_ARGS $1')')
define(`ENVIRONMENT', `ifelse(ENV_VARS, `', , `map(`ENV_CMD', `
', translit(ENV_VARS, ` ', `,'))')')
define(`ENV_CMD', `ENV $1')

define(`LABELS',
`LABEL_PREFIX
LABEL org.opencontainers.image.title="IMAGE_TITLE"
LABEL org.opencontainers.image.description="container for building PACKAGE on DISTRO/RELEASE/TAG"
EXTRA_LABELS
LABEL_SUFFIX')

define(`DOWNLOAD', `RUN wget --no-check-certificate -q "$1"')

define(CMOCKA_DEFS, `')
define(`_BUILD_CMOCKA',
`RUN_CMD(`INSTALL CMOCKA_DEPS')
WORKDIR /tmp
DOWNLOAD(`https://cmocka.org/files/patsubst(CMOCKA_VER, \([0-9]\.[0-9]\)\..*, \1)/cmocka-CMOCKA_VER.tar.xz', `cmocka-CMOCKA_VER.tar.xz')
RUN_CMD(`tar xfJ cmocka-CMOCKA_VER.tar.xz && \
    mkdir -p cmocka-CMOCKA_VER/build && \
    rm -f cmocka-CMOCKA_VER/CMakeCache.txt')
WORKDIR /tmp/cmocka-CMOCKA_VER/build
RUN_CMD(`cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release CMOCKA_DEFS ..')
RUN_CMD(`make')
RUN_CMD(`make install')
RUN_CMD(`rm -rf /tmp/cmocka*')
RUN_CMD(`REMOVE(`CMOCKA_DEPS')')')

define(`BUILD_CMOCKA',
`ifdef(`CMOCKA_VER', `ifdef(`NEED_CMOCKA', `_BUILD_CMOCKA', `dnl')', `dnl')')

define(`try_include',
`syscmd(`test -f $1')
 ifelse(sysval, 0,
 	`include(`$1')',
	`errprint(`"$1" does not exist
')
	m4exit')')

# map operation on comma-separated list, ends up space-separated
define(`map',
	`ifelse($#, 0, , $#, 1, ,
	 $#, 2, `$1($2)',
	 `$1($2) map(`$1', shift(shift($@)))')')

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
define(`map_spc', `map(`$1', translit($2, ` ', `,'))')

define(`BUILD_PKGS', `build_pkgs extra_build')
define(`DEVEL_PKGS',
`map_spc(`devext', `dev_pkgs') ifelse(extra_dev, `', , map_spc(`devext', `extra_dev'))')

define(CMOCKA_DEFS, `')
define(`_BUILD_CMOCKA',
`RUN_CMD(`INSTALL CMOCKA_DEPS')
WDIR(`/tmp')
RUN_CMD(`wget --no-check-certificate -q https://cmocka.org/files/patsubst(CMOCKA_VER, \([0-9]\.[0-9]\)\..*, \1)/cmocka-CMOCKA_VER.tar.xz')
RUN_CMD(`tar xfJ cmocka-CMOCKA_VER.tar.xz && \
    mkdir -p cmocka-CMOCKA_VER/build && \
    rm -f cmocka-CMOCKA_VER/CMakeCache.txt')
WDIR(`/tmp/cmocka-CMOCKA_VER/build')
RUN_CMD(`cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release CMOCKA_DEFS ..')
RUN_CMD(`make')
RUN_CMD(`make install')
RUN_CMD(`rm -rf /tmp/cmocka*')
RUN_CMD(`REMOVE(`CMOCKA_DEPS')')')

define(`BUILD_CMOCKA',
`ifdef(`CMOCKA_VER', `_BUILD_CMOCKA', `dnl')')

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

define(`devel_pkgs',
`map_spc(`devext', `dev_pkgs') ifelse(extra_dev, `', , map_spc(`devext', `extra_dev'))')

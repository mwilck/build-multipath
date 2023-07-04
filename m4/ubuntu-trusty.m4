define(`dev_pkgs', patsubst(dev_pkgs, ` cmocka', `'))
define(`CMOCKA_VER', `1.0.1')
define(`CMOCKA_DEPS', `wget xz-utils cmake')
define(`devext',
`ifelse($1, `pkgconf', `',
        `lib$1-dev')')

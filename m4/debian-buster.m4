define(`devext',
`ifelse($1, `pkgconf', `',
        `lib$1-dev')')

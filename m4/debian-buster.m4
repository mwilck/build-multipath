define(`devext',
`ifelse($1, `pkgconf', `',
        `lib$1-dev')')
define(`PREINSTALL', `RUN sed -i ''`s/deb\.debian\.org/archive.debian.org/''` /etc/apt/sources.list')
define(`UPDATE', `apt-get -o Acquire::Check-Valid-Until=false update')

define(`ADD_DEBSRC',
`RUN sed -i ''`/^Types/s/deb/deb deb-src/''` /etc/apt/sources.list.d/debian.sources')

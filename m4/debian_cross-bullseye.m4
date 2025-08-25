define(`TAG', `bullseye-20240904')
define(`ADD_DEBSRC',
`RUN sed  -i ''`/snapshot/!d;/snapshot/{s/^# //;p;s/^deb/deb-src/;}''` /etc/apt/sources.list')
define(`UPDATE', `apt-get -o Acquire::Check-Valid-Until=false update')

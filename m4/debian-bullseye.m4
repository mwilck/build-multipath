# Versioned libraries. e.g. for bullseye, map "devmapper" -> "libdevmapper1.02.1"
define(`TAG', `bullseye-20240904')
define(`libver',
    `ifelse($1, `cmocka', 0, $1, `urcu', 6, $1, `json-c', 5, $1, `edit', 2,
            $1, `readline', 8, $1, `devmapper', `1.02.1', 1)')
define(`PREINSTALL', `RUN sed  -i ''`/snapshot/!d;/snapshot/s/^# //''` /etc/apt/sources.list')
define(`UPDATE', `apt-get -o Acquire::Check-Valid-Until=false update')

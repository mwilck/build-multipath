define(`base', `debian:buster')
define(`devext', `lib$1-dev')
define(`INSTALL', `apt-get update && apt-get install --yes')
define(`CLEAN', `RUN apt-get clean')
# extra packages

# package renames
define(`pkgconfig', `pkg-config')

include(`fedora.m4')
define(`DEFAULT_RELEASE', `8')
define(`PREINSTALL', `RUN DNF install -y epel-release')
define(`DNF', `yum')

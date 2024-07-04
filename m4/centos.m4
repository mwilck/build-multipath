include(`fedora.m4')
define(`DEFAULT_RELEASE', `8')
define(`PREINSTALL', `ADD CentOS-Base.repo /etc/yum.repos.d/')
RUN DNF install -y epel-release')
define(`DNF', `yum')
define(`devext',
`ifelse($1, pkgconf, ,
        `rename($1)-devel')')

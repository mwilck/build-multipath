include(`fedora.m4')
define(`DEFAULT_TAG', `8')
define(`DNF', `ifelse(TAG, `8', `dnf', `yum')')
# https://yegorshytikov.medium.com/error-failed-to-download-metadata-for-repo-appstream-cannot-prepare-internal-mirrorlist-no-959768e5f8e5
define(`PREINSTALL',
`ifelse(TAG, `8',
`RUN sed -i "s/mirrorlist/#mirrorlist/;s|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|" /etc/yum.repos.d/CentOS-*
RUN DNF install -y \
    epel-release \
    "dnf-command(config-manager)"
RUN DNF config-manager --set-enabled powertools',
`RUN DNF install -y epel-release')')

define(`DNF', `dnf')
# https://yegorshytikov.medium.com/error-failed-to-download-metadata-for-repo-appstream-cannot-prepare-internal-mirrorlist-no-959768e5f8e5
define(`PREINSTALL',
`RUN sed -i "s/mirrorlist/#mirrorlist/;s|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|" /etc/yum.repos.d/CentOS-*
RUN DNF install -y \
    epel-release \
    "dnf-command(config-manager)"
RUN DNF config-manager --set-enabled powertools')

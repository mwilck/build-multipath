define(`build_pkgs', `meson gcc gplusplus clang pkgconfig ca-certificates git make py3setuptools swig bash')
define(`dev_pkgs', `ssl json-c keyutils dbus-1 pam cap-ng pkgconf curl4-openssl archive')
define(`RUNTIME_PKGS', `bash')
define(`entrypoint', `/build/scripts/build.sh')

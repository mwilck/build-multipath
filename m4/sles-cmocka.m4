define(`dev_pkgs', patsubst(dev_pkgs, ` cmocka', `'))
define(`CMOCKA_VER', `1.1.5')
define(`CMOCKA_DEPS', `cmake wget tar xz')
define(`CMOCKA_DEFS', `-DLIB_INSTALL_DIR:PATH=/usr/lib64 -DCMAKE_INSTALL_LIBDIR:PATH=/usr/lib64')

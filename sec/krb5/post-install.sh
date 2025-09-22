#!/bin/sh

pkg_postinst() {
    cd /usr/share/blfs-bootscripts
    make install-krb5
}

pkg_preremove() {
    cd /usr/share/blfs-bootscripts
    make uninstall-krb5
}

case $1 in
    postinst) pkg_postinst ;;
    preremove) pkg_preremove ;;
esac
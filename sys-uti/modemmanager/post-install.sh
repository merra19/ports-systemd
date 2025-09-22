#!/bin/sh

pkg_postinst() {
    systemctl enable ModemManager
}

pkg_preremove() {
    systemctl disable ModemManager
}

case $1 in
    postinst) pkg_postinst ;;
    preremove) pkg_preremove ;;
esac
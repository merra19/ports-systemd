#!/bin/sh

pkg_postinst() {
    systemctl enable smartd
}

pkg_preremove() {
    systemctl disable smartd
}

case $1 in
    postinst) pkg_postinst ;;
    preremove) pkg_preremove ;;
esac
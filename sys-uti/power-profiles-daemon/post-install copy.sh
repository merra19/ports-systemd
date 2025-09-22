#!/bin/sh

pkg_postinst() {
    systemctl enable power-profiles-daemon
}

pkg_preremove() {
    systemctl disable power-profiles-daemon
}

case $1 in
    postinst) pkg_postinst ;;
    preremove) pkg_preremove ;;
esac
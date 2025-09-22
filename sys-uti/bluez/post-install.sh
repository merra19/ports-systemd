#!/bin/sh

pkg_postinst() {
    systemctl enable bluetooth
    systemctl enable --global obex
}

pkg_preremove() {
    systemctl disable --global obex
    systemctl disable bluetooth
}

case $1 in
    postinst) pkg_postinst ;;
    preremove) pkg_preremove ;;
esac
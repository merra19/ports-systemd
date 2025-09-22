#!/bin/sh

pkg_postinst() {
    systemctl enable avahi-dnsconfd
}

pkg_preremove() {
    systemctl disable avahi-dnsconfd
}

case $1 in
    postinst) pkg_postinst ;;
    preremove) pkg_preremove ;;
esac
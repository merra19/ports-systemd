#!/bin/sh

pkg_postinst() {
    systemd-machine-id-setup
}

case $1 in
    postinst) pkg_postinst ;;
esac
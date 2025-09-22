#!/bin/sh

pkg_postinst() {
    systemctl enable --global wireplumber
}

case $1 in
    postinst) pkg_postinst ;;
esac
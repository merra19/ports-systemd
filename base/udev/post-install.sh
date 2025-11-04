#!/bin/sh

pkg_postinst() {
    udev-hwdb update
}

case $1 in
    postinst) pkg_postinst ;;
esac

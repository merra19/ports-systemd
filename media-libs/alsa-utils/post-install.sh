#!/bin/sh

pkg_postinst() {
    alsactl init
    alsactl -L store
}

case $1 in
    postinst) pkg_postinst ;;
esac
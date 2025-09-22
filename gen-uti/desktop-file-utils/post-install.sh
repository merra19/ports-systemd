#!/bin/sh

pkg_postinst() {
    update-desktop-database --quiet
}

pkg_postupgrade() {
    pkg_postinst
}

case $1 in
    postinst) pkg_postinst ;;
    postupgrade) pkg_postupgrade ;;
esac
#!/bin/sh

pkg_postinst() {
    fc-cache -f
}

pkg_postupgrade() {
    pkg_postinst
}

pkg_postremove() {
    pkg_postinst
}

case $1 in
    postinst) pkg_postinst ;;
    postupgrade) pkg_postupgrade ;;
    postremove) pkg_postremove ;;
esac
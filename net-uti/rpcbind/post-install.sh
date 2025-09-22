#!/bin/sh

pkg_postinst() {
    systemctl enable rpcbind
}

pkg_preremove() {
    systemctl disable rpcbind
}

case $1 in
    postinst) pkg_postinst ;;
    preremove) pkg_preremove ;;
esac
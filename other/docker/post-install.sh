#!/bin/sh

pkg_preinst() {
    getent group docker || groupadd --system -g 132 docker 
}

case $1 in
    preinst) pkg_preinst ;;
esac
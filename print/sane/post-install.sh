#!/bin/sh

pkg_preinst() {
    getent group scanner || groupadd -g 70 scanner
}

pkg_postinst() {
	mkdir -p /run/lock/sane
	chgrp -v scanner  /run/lock/sane
}

case $1 in
    preinst) pkg_preinst ;;
	postinst) pkg_postinst ;;
esac

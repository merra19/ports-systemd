#!/bin/sh

pkg_preinst() {
    getent group postfix > /dev/null || groupadd -g 32 postfix
    getent group postdrop > /dev/null || groupadd -g 33 postdrop
    getent passwd postfix > /dev/null || useradd -c "Postfix Daemon User" -g postfix -d /var/spool/postfix -s /bin/false -u 32 postfix
}

case $1 in
    preinst) pkg_preinst ;;
esac

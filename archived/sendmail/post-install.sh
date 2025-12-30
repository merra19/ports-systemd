#!/bin/sh

pkg_preinst() {
    getent group smmsp > /dev/null || groupadd -g 26 smmsp
    getent passwd smmsp > /dev/null || useradd -c "Sendmail Daemon" -g smmsp -d /dev/null -s /bin/false -u 26 smmsp

    install -v -m700 -d /var/spool/mqueue
}

case $1 in
    preinst) pkg_preinst ;;
esac

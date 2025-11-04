#!/bin/sh

pkg_preinst() {
    getent group postgres > /dev/null || groupadd -g 41 postgres
    getent passwd postgres > /dev/null || useradd -c "PostgreSQL Server" -g postgres -d /srv/pgsql/data -u 41 postgres
}

pkg_postinst() {
    su - postgres -c '/usr/bin/initdb -D /srv/pgsql/data'
}

case $1 in
    preinst) pkg_preinst ;;
    postinst) pkg_postinst ;;
esac

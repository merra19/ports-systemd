#!/bin/sh

pkg_preinst() {
getent group lighttpd || groupadd -g 49 lighttpd
getent passwd lighttpd  || useradd -c "Lighttpd Server"  -g lighttpd -s /bin/false -u 49 lighttpd
}

case $1 in
	preinst) pkg_preinst ;;
esac
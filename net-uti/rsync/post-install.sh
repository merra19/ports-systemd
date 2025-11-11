#!/bin/sh

pkg_preinst() {
	getent group rsyncd > /dev/null || groupadd -g 48 rsyncd 
	getent passwd rsyncd > /dev/null || useradd -c "rsyncd Daemon" -m -d /home/rsync -g rsyncd -s /bin/false -u 48 rsyncd
}

case $1 in
    preinst) pkg_preinst ;;
esac
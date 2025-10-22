#!/bin/sh

pkg_preinst() {
	getent group qbittorrent > /dev/null || groupadd -g 534 qbittorrent
	getent passwd qbittorrent > /dev/null || useradd -d /var/lib/qbittorrent -c "Qbitorrent User" -g qbittorrent -s /bin/false -u 534 qbittorrent
}

case $1 in
    preinst) pkg_preinst ;;
esac
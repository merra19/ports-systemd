#!/bin/sh

pkg_preinst() {
    getent group sddm || groupadd -g 64 sddm
    getent passwd sddm || useradd  -c "sddm Daemon" -d /var/lib/sddm -u 64 -g sddm -s /bin/false sddm
}

pkg_postinst() {
    if ! grep -q '^dm:5' /etc/inittab; then \
		echo dm:5:respawn:/etc/rc.d/init.d/xdm >> /etc/inittab; \
	fi
}

case $1 in
    preinst) pkg_preinst ;;
esac

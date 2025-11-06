#!/bin/sh

pkg_preinst() {
	getent group unbound > /dev/null || groupadd -g 88 unbound
	getent passwd unbound > /dev/null || useradd -c "Unbound DNS Resolver" -d /var/lib/unbound -u 88 -g unbound -s /bin/false unbound 
}

pkg_postinst() {
	systemctl disable systemd-resolved --now

	unbound-anchor
	chown unbound /etc/unbound/root.key

	if  [ ! -f /etc/resolv.conf.bak ]; then
		cp /etc/resolv.conf /etc/resolv.conf.bak
	cat > /etc/resolv.conf << "EOF"
nameserver ::1
nameserver 127.0.0.1
options edns0 trust-ad
EOF
	fi

    cd /usr/share/blfs-bootscripts
    make install-unbound
}

pkg_preremove() {
	systemctl disable unbound

    cd /usr/share/blfs-bootscripts
    make uninstall-unbound
}

case $1 in
	preinst) pkg_preinst ;;
    postinst) pkg_postinst ;;
    preremove) pkg_preremove ;;
esac

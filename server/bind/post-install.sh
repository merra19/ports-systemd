#!/bin/sh

pkg_preinst() {
	getent group named > /dev/null || groupadd -g 20 named 
	getent passwd named > /dev/null || useradd -c "BIND Owner" -g named -s /bin/false -u 20 named 
}

pkg_postinst() {
	if [ ! -f /etc/bind/rndc.key ]; then
		rndc-confgen -a -b 512 -t /srv/named
	fi

	if [ ! -f /etc/resolv.conf.bak ]; then
		cp /etc/resolv.conf /etc/resolv.conf.bak &&
		cat > /etc/resolv.conf << "EOF"
search <yourdomain.com>
nameserver 127.0.0.1
EOF
	fi
}

case $1 in
	preinst) pkg_preinst ;;
    postinst) pkg_postinst ;;
esac

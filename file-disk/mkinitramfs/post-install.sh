#!/bin/sh

HOOKS="base modules udev automod filedisk systemd"

pkg_postinst() {
	for h in $HOOKS; do
		if [ -f /etc/mkinitramfs.d/$h.hook ]; then
			rm -f /etc/mkinitramfs.d/$h.hook
			install -m755 /usr/share/mkinitramfs/hooks/$h.hook /etc/mkinitramfs.d/$h.hook
		else
			install -m755 /usr/share/mkinitramfs/hooks/$h.hook /etc/mkinitramfs.d/$h.hook
		fi
	done
}

pkg_preremove() {
	for h in $HOOKS; do
		if [ -f /etc/mkinitramfs.d/$h.hook ]; then
			rm -f /etc/mkinitramfs.d/$h.hook
		fi
	done
}

case $1 in
    postinst) pkg_postinst ;;
    preremove) pkg_preremove ;;
esac
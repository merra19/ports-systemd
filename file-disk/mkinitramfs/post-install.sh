#!/bin/sh


pkg_postinst() {
	for h in base modules udev automod; do
		if [ -f /etc/mkinitramfs.d/$h.hook ]; then
			install -m755 /usr/share/mkinitramfs/hooks/$h.hook /etc/mkinitramfs.d/$h.hook.spkgnew
		else
			install -m755 /usr/share/mkinitramfs/hooks/$h.hook /etc/mkinitramfs.d/$h.hook
		fi
	done
}

pkg_preremove() {
    pkg_postinst
}

case $1 in
    postinst) pkg_postinst ;;
    preremove) pkg_preremove ;;
esac
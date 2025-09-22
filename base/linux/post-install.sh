#!/bin/sh

pkg_postinst() {
	kernver=$(find /lib/modules -maxdepth 1 -type d -iname '*-linux' -printf "%f\n")


	# removing other venom's kernel
	for i in /lib/modules/*; do
		[ -d $i ] || continue
		case ${i##*/} in
			$kernver) continue;;
			*-linux)
				[ -d $i/build/include ] && continue
				echo "post-install: removing kernel ${i##*/}"
				rm -fr $i;;
		esac
	done


	if [ $(command -v mkinitramfs) ]; then
		echo "mkinitramfs: generating initramfs for kernel $kernver..."
		mkinitramfs -q -k $kernver -o /boot/initrd-linux.img
	fi


	# load kernel modules
	depmod $kernver

	# run all dkms scripts
	if [ $(command -v dkms) ]; then
		for i in /var/lib/dkms/buildmodules-*.sh; do
			[ -f $i ] && sh $i
		done
	fi
}

case $1 in
    #postinst) pkg_postinst ;;
    postupgrade) pkg_postinst ;;
    #preremove) pkg_preremove ;;
esac
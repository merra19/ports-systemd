#!/bin/sh

pkg_postinst() {
	kernver=$(find /lib/modules -maxdepth 1 -type d -iname '*-linux' -printf "%f\n")

    cd /boot
    mkinitramfs -k $kname
    depmod $kname

    # run all dkms scripts
    if [ $(command -v dkms) ]; then
        for i in /var/lib/dkms/buildmodules-*.sh; do
            sh $i
        done
    fi
}

pkg_postupgrade() {
    pkg_postinst
}

pkg_preremove() {
    version="$(awk 'NR==1 {print $1}' /var/lib/scratchpkg/db/$name)"
    (
        cd /usr/lib/modules/$kname/
        for i in * ;do
            case $i in
                modules.order | modules.builtin | modules.builtin.modinfo) ;;
                modules.*) rm -f $i ;;
                *) ;;
            esac
        done
    )
    echo "cleaning initramfs"
    rm -fv /boot/initrd.img-$kname
}

case $1 in
    postinst) pkg_postinst ;;
    postupgrade) pkg_postupgrade ;;
    preremove) pkg_preremove ;;
esac
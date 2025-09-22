#!/bin/sh

pkg_postinst() {
    gtk-update-icon-cache -qtf /usr/share/icons/hicolor

    systemctl enable cups
}

pkg_postupgrade() {
    gtk-update-icon-cache -qtf /usr/share/icons/hicolor
}

pkg_preremove() {
    systemctl disable cups
}

case $1 in
    preinst) pkg_preinst ;;
    postinst) pkg_postinst ;;
    postupgrade) pkg_postupgrade ;;
    preremove) pkg_preremove ;;
esac
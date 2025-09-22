#!/bin/sh

pkg_preinst() {
    getent group fcron > /dev/null || groupadd -g 22 fcron
    getent passwd fcron > /dev/null || useradd -d /dev/null -c "Fcron User" -g fcron -s /bin/false -u 22 fcron
}

pkg_postinst() {
    systemctl enable fcron
    
    fcrontab -z -u systab
}

pkg_preremove() {
    systemctl disable fcron
}

case $1 in
    preinst) pkg_preinst ;;
    postinst) pkg_postinst ;;
    preremove) pkg_preremove ;;
esac
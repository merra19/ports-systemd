#!/bin/sh

pkg_postinst() {
    echo "rebuild gdk-pixbuf "
    scratch -I -y -f -r gdk-pixbuf
}


case $1 in
    postinst) pkg_postinst ;;
esac

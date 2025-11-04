#!/bin/sh

pkg_postinst() {
    if [ ! -f /usr/lib/krb5/plugins/kdb/kldap.so ];then
        echo "rebuild krb5"
        echo "scratch -I -y -f -r krb5"
        exit 1
    fi
}

case $1 in
    postinst) pkg_postinst ;;
esac

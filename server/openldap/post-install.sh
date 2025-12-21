#!/bin/sh

pkg_postinst() {
    if [ ! -f /usr/lib/krb5/plugins/kdb/kldap.so ];then
        echo "rebuild krb5"
        if  (scratch isinstalled krb5);then
            scratch -I -y -f -r krb5
        fi
    fi
}

case $1 in
    postinst) pkg_postinst ;;
esac

#!/bin/sh

pkg_postinst() {
    (fcrontab -l -u systab ; echo "@daily $(which trash-empty) 30") | fcrontab -u systab -
}

pkg_postremove() {
    fcrontab -l -u systab | grep -v "@daily /usr/bin/trash-empty 30" | fcrontab -u systab -
}

case $1 in
    postinst) pkg_postinst ;;
    postremove) pkg_postremove ;;
esac

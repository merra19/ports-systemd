#!/bin/sh

pkg_postinst() {
    systemctl --global enable pipewire.socket  
    systemctl --global enable pipewire-pulse.socket
    systemctl --global disable pulseaudio
}

case $1 in
    postinst) pkg_postinst ;;
esac
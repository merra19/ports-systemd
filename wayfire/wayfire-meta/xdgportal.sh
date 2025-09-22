#!/bin/sh

sleep 1
killall xdg-desktop-portal-gtk
killall xdg-desktop-portal-gnome
killall xdg-desktop-portal-wlr
killall xdg-desktop-portal
logger 'killed all xdg-desktop'
sleep 1

dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
sleep1
/usr/libexec/xdg-desktop-portal-gtk &
logger 'xdg-desktop-portal-gtk started'
sleep2
/usr/libexec/xdg-desktop-portal-wlr &
logger 'xdg-desktop-portal-wlr started'
sleep 2
/usr/libexec/xdg-desktop-portal &
logger 'xdg-desktop-portal started'  

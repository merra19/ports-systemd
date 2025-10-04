#!/bin/sh

export LC_ALL=C.UTF-8

skip_chrooted() {
  if systemd-detect-virt --chroot; then
    echo >&2 "  Skipped: Running in chroot."
    return 1
  fi
  return 0
}

systemd_live() {
  skip_chrooted || return 1

  if ! systemd-notify --booted >/dev/null 2>&1; then
    echo >&2 "  Skipped: Current root is not booted."
    return 1
  fi

  return 0
}

udevd_live() {
  skip_chrooted

  if [ ! -S /run/udev/control ]; then
    echo >&2 "  Skipped: Device manager is not running."
    return 0
  fi
}

for op in sysusers catalog daemon-reload-system daemon-reload-user \
    hwdb restart-marked sysctl tmpfiles udev-reload  \
    dbus-reload ;do

    case "$op" in
    catalog)
        /usr/bin/journalctl --update-catalog
        ;;
    daemon-reload-system)
        systemd_live && /usr/bin/systemctl --system daemon-reload
        ;;
    daemon-reload-user)
        systemd_live && /usr/bin/systemctl reload 'user@*.service'
        ;;
    hwdb)
        /usr/bin/systemd-hwdb --usr update
        ;;
    sysctl)
        systemd_live && /usr/lib/systemd/systemd-sysctl
        ;;
    sysusers)
        #/usr/bin/systemd-sysusers
        ;;
    tmpfiles)
        /usr/bin/systemd-tmpfiles --create
        ;;
    udev-reload)
        udevd_live
        /usr/bin/udevadm control --reload
        if [ ! -e /etc/systemd/do-not-udevadm-trigger-on-update ]; then
        /usr/bin/udevadm trigger -c change
        /usr/bin/udevadm settle
        fi
        ;;

    # marked with 'systemctl set-property ... Markers=needs-restart'
    restart-marked)
        systemd_live && /usr/bin/systemctl reload-or-restart --marked
        ;;

    dbus-reload)
        systemd_live && /usr/bin/systemctl try-reload-or-restart dbus
        ;;

    # For use by other packages
    reload)
        systemd_live && /usr/bin/systemctl try-reload-or-restart "$@"
        ;;

    *)
        echo >&2 "  Invalid operation '$op'"
        exit 1
        ;;
    esac
done
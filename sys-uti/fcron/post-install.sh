#!/bin/sh

skip_chrooted() {
  if [ "$(stat -c %d:%i /)" != "$(stat -c %d:%i /proc/1/root/.)" ]; then
    echo >&2 "  Skipped: Running in chroot."
    return 1
  fi
  return 0
}

pkg_preinst() {
    getent group fcron > /dev/null || groupadd -g 22 fcron
    getent passwd fcron > /dev/null || useradd -d /dev/null -c "Fcron User" -g fcron -s /bin/false -u 22 fcron
}

pkg_postinst() {
    skip_chrooted && /etc/rc.d/init.d/fcron start
    fcrontab -z -u systab
}


case $1 in
    preinst) pkg_preinst ;;
    postinst) pkg_postinst ;;
esac

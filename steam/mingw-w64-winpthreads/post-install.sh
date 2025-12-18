#!/bin/sh

pkg_postinst() {
    echo "rebuild mingw-w64-gcc after mingw-w64-winpthreads"
    echo "scratch -I -y -f -r mingw-w64-gcc"

    version="$(awk 'NR==1 {print $1}' /var/lib/scratchpkg/db/mingw-w64-gcc)"

    if [ ! -f  /usr/x86_64-w64-mingw32/include/c++/$version/x86_64-w64-mingw32/ext/opt_random.h ];then
        scratch -I -y -f -r mingw-w64-gcc
    fi
}

postupgrade() {
    pkg_postinst
}



case $1 in
    postinst) pkg_postinst ;;
    postupgrade) pkg_postupgrade ;;
esac

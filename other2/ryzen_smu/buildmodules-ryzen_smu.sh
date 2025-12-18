#!/bin/sh

for KVER in $(ls /lib/modules/); do
	[ -z "$KVER" ] || KVER=$(uname -r)
	echo "dkms: building @name@ modules for kernel $KVER..."
	rm -fr /var/lib/dkms/@name@
	dkms add -m @name@ -v @version@ -k $KVER >/dev/null 2>&1
	dkms build -m @name@ -v @version@ -k $KVER >/dev/null 2>&1
	dkms install -m @name@ -v @version@ -k $KVER >/dev/null 2>&1
done

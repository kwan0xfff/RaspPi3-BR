#!/bin/sh

set -u
set -e

# Add a console on tty1
if [ -e ${TARGET_DIR}/etc/inittab ]; then
    grep -qE '^tty1::' ${TARGET_DIR}/etc/inittab || \
	sed -i '/GENERIC_SERIAL/a\
tty1::respawn:/sbin/getty -L  tty1 0 vt100 # HDMI console' ${TARGET_DIR}/etc/inittab
fi

TARGETDIR=$1
BR_ROOT=$PWD

# mount points
mkdir -p $TARGETDIR/boot
mkdir -p $TARGETDIR/data

# fstab
install -T -m 0644 $BR_ROOT/system/skeleton/etc/fstab $TARGETDIR/etc/fstab
echo '/dev/mmcblk0p1 /boot auto defaults 0 0' >> $TARGETDIR/etc/fstab
echo '/dev/mmcblk0p3 /data auto defaults 0 0' >> $TARGETDIR/etc/fstab


# README for RaspPi3-BR

This is an exercise in crafting a Buildroot image for Raspberry Pi 3.

This repository consists configuration files and (eventually) build
notes related to the build.


## Configuration

The Buildroot repository resides at: `git://git.busybox.net/buildroot`
At this writing, the Buildroot image is built from git tag `2017.05`.

### Root filesystem (rootfs)

The root filesystem is currently sized to about 126 MB.
This was in anticipation of additional packages, which have not yet been added.
The following packages were added into the rootfs filesystem image.

* ncurses - needed by `nano`
* nano - simple full-screen editor
* zlib
* OpenSSL
* OpenSSH - provides ssh, scp, sftp
* ptpd, ptpd2

## Networking

Device is configured via `/etc/network/interfaces` to set `eth0` to
static IP address 192.168.0.230.

New authentication keys are created in /etc/ssh during bootup.
The public keys can be used to enable remote access to this system
without the need of passwords.

## Building the image

The build itself:

    make 2>&1 | tee build.log

Copying the image to microSD:

    dd if=output/images/sdcard.img of=/dev/sdX

where `sdX` is the host device for microSD.

# Open issues

* Data partition not created -
  `/etc/init.d/S35checkDataPartition` is supposed to cehck for existence
  of data partition on /dev/mmcblk0p2 on bootup, and if it doesn't exist,
  create it.  This is not happening.

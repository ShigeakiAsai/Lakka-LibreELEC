#!/bin/sh

# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

[ -z "$SYSTEM_ROOT" ] && SYSTEM_ROOT=""
[ -z "$BOOT_ROOT" ] && BOOT_ROOT="/flash"
[ -z "$BOOT_PART" ] && BOOT_PART=$(df "$BOOT_ROOT" | tail -1 | awk {' print $1 '})

# identify the boot device
if [ -z "$BOOT_DISK" ]; then
  case $BOOT_PART in
    /dev/sd[a-z][0-9]*)
      BOOT_DISK=$(echo $BOOT_PART | sed -e "s,[0-9]*,,g")
      ;;
    /dev/mmcblk*)
      BOOT_DISK=$(echo $BOOT_PART | sed -e "s,p[0-9]*,,g")
      ;;
  esac
fi

# update u-boot (S922X)
# The image writes u-boot.bin.sd.bin to the start of the disk: the boot code
# (the first 440 bytes, keeping the disk signature and partition table) and
# everything after the first sector. Do the same here, so that fixes in u-boot
# also reach an installed system.
# u-boot is built per board after SYSTEM, so SYSTEM has it only when built
# with UBOOT_SYSTEM. An .img.gz update has it too: init mounts the boot
# partition of the new image at /storage/.update/.tmp/mnt before running this
# script, and mkimage copies u-boot.bin.sd.bin into that partition.
# The first partition starts at 4 MiB, so a larger file would overwrite it.
UBOOT_BIN=""
for f in "$SYSTEM_ROOT/usr/share/bootloader/u-boot.bin.sd.bin" \
         "/storage/.update/.tmp/mnt/u-boot.bin.sd.bin"; do
  if [ -f "$f" ]; then
    UBOOT_BIN="$f"
    break
  fi
done
if [ -n "$UBOOT_BIN" ] && [ -b "$BOOT_DISK" ]; then
  # "ls -ln": the initramfs busybox is built without FEATURE_LS_USERNAME,
  # so "ls -l" there prints no owner or group, and the size is not field 5.
  UBOOT_SIZE=$(ls -ln "$UBOOT_BIN" | awk '{ print $5 }')
  if [ -n "$UBOOT_SIZE" ] && [ "$UBOOT_SIZE" -lt 4194304 ]; then
    echo "Updating u-boot on $BOOT_DISK"
    dd if="$UBOOT_BIN" of="$BOOT_DISK" conv=fsync,notrunc bs=1 count=440 >/dev/null 2>&1
    dd if="$UBOOT_BIN" of="$BOOT_DISK" conv=fsync,notrunc bs=512 skip=1 seek=1 >/dev/null 2>&1
  else
    echo "Not updating u-boot: size of $UBOOT_BIN is unknown or too large ($UBOOT_SIZE)"
  fi
fi

# mount $BOOT_ROOT rw
mount -o remount,rw $BOOT_ROOT

# update /amlogic device trees
if [ -d $BOOT_ROOT/amlogic ]; then
  for dtbfile in $BOOT_ROOT/amlogic/*.dtb; do
    dtb=$(basename $dtbfile)
    if [ -f $SYSTEM_ROOT/usr/share/bootloader/$dtb ]; then
      echo "Updating $dtb"
      cp -p $SYSTEM_ROOT/usr/share/bootloader/$dtb $BOOT_ROOT/amlogic/
    fi
  done
fi

# update /extlinux device trees
if [ -f $BOOT_ROOT/extlinux/extlinux.conf ]; then
  for dtbfile in $BOOT_ROOT/*.dtb; do
    # The ODROID-GO Ultra keeps its device trees in /amlogic, so this
    # pattern may match nothing. It then stays "*.dtb", and the test below
    # would expand it to every dtb in SYSTEM ("unknown operand").
    [ -f "$dtbfile" ] || continue
    dtb=$(basename $dtbfile)
    if [ -f $SYSTEM_ROOT/usr/share/bootloader/$dtb ]; then
      echo "Updating $dtb"
      cp -p $SYSTEM_ROOT/usr/share/bootloader/$dtb $BOOT_ROOT/
    fi
  done
fi

# update /dtb device trees
if [ -d $BOOT_ROOT/dtb ]; then
  for dtbfile in $BOOT_ROOT/dtb/*.dtb; do
    dtb=$(basename $dtbfile)
    if [ -f $SYSTEM_ROOT/usr/share/bootloader/$dtb ]; then
      echo "Updating $dtb"
      cp -p $SYSTEM_ROOT/usr/share/bootloader/$dtb $BOOT_ROOT/dtb/
    fi
  done
fi

# update u-boot scripts
if [ -f $BOOT_ROOT/uEnv.ini ]; then
  for scriptfile in $SYSTEM_ROOT/usr/share/bootloader/*_autoscript* $SYSTEM_ROOT/usr/share/bootloader/*.scr; do
    script=$(basename $scriptfile)
    if [ -f $SYSTEM_ROOT/usr/share/bootloader/$script ]; then
      echo "Updating $script"
      cp -p $SYSTEM_ROOT/usr/share/bootloader/$script $BOOT_ROOT/
    fi
  done
fi

# mount $BOOT_ROOT ro
sync
mount -o remount,ro $BOOT_ROOT

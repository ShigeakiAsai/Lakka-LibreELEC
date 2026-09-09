# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="u-boot"
PKG_VERSION="9235942906216dc529c1e96f67dd2364a94d0738"
PKG_SHA256="283a003693e9d3b33f84d84f5aa05e732619a17d14902bab09d887357bce702a"
PKG_ARCH="aarch64"
PKG_LICENSE="GPL"
PKG_SITE="https://www.denx.de/wiki/U-Boot"
PKG_URL="https://github.com/hardkernel/u-boot/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain openssl:host pkg-config:host Python3:host swig:host pyelftools:host gcc-linaro-aarch64-elf:host gcc-linaro-arm-eabi:host"
PKG_LONGDESC="Das U-Boot is a cross-platform bootloader for embedded systems."

PKG_IS_KERNEL_PKG="yes"
PKG_STAMP="$UBOOT_SYSTEM $UBOOT_TARGET"

if [ -n "$UBOOT_FIRMWARE" ]; then
  PKG_DEPENDS_TARGET+=" $UBOOT_FIRMWARE"
  PKG_DEPENDS_UNPACK+=" $UBOOT_FIRMWARE"
fi

PKG_NEED_UNPACK="$PROJECT_DIR/$PROJECT/bootloader"
[ -n "$DEVICE" ] && PKG_NEED_UNPACK+=" $PROJECT_DIR/$PROJECT/devices/$DEVICE/bootloader"

make_target() {
  if [ -z "$UBOOT_SYSTEM" ]; then
    echo "UBOOT_SYSTEM must be set to build an image"
    echo "see './scripts/uboot_helper' for more information"
  else
    [ "${BUILD_WITH_DEBUG}" = "yes" ] && PKG_DEBUG=1 || PKG_DEBUG=0
    [ -n "$UBOOT_FIRMWARE" ] && find_file_path bootloader/firmware && . ${FOUND_PATH}
    export PATH=${TOOLCHAIN}/lib/gcc-linaro-aarch64-elf/bin/:${TOOLCHAIN}/lib/gcc-linaro-arm-eabi/bin/:${PATH}
    DEBUG=${PKG_DEBUG} CROSS_COMPILE=aarch64-elf- LDFLAGS="" ARCH=arm make mrproper
    DEBUG=${PKG_DEBUG} CROSS_COMPILE=aarch64-elf- LDFLAGS="" ARCH=arm make $($ROOT/$SCRIPTS/uboot_helper $PROJECT $DEVICE $UBOOT_SYSTEM config)
    DEBUG=${PKG_DEBUG} CROSS_COMPILE=aarch64-elf- LDFLAGS="" ARCH=arm CFLAGS="" _python_sysroot="$TOOLCHAIN" _python_prefix=/ _python_exec_prefix=/ make $UBOOT_TARGET HOSTCC="$HOST_CC" HOSTCFLAGS="-I${TOOLCHAIN}/include" HOSTLDFLAGS="-L$TOOLCHAIN/lib" HOSTSTRIP="true" CONFIG_MKIMAGE_DTC_PATH="scripts/dtc/dtc"
  fi
}

post_make_target() {
  if [ -f "${PKG_BUILD}/build/u-boot.bin" ]; then
    cp -av "${PKG_BUILD}/build/u-boot.bin" "${PKG_BUILD}/u-boot.bin"
  fi
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/bootloader

  # Only install u-boot.img et al when building a board specific image
  if [ -n "$UBOOT_SYSTEM" ]; then
    find_file_path bootloader/install && . ${FOUND_PATH}
  fi

  # Always install the update script
  find_file_path bootloader/update.sh && cp -av ${FOUND_PATH} $INSTALL/usr/share/bootloader

  # Always install the canupdate script
  if find_file_path bootloader/canupdate.sh; then
    cp -av ${FOUND_PATH} $INSTALL/usr/share/bootloader
    sed -e "s/@PROJECT@/${DEVICE:-$PROJECT}/g" \
        -i $INSTALL/usr/share/bootloader/canupdate.sh
  fi

  if [ -d "${PKG_BUILD}/tools/odroid_resource/res" ]; then
    cp -av "${PKG_BUILD}/tools/odroid_resource/res" "${INSTALL}/usr/share/bootloader/"
  fi
}

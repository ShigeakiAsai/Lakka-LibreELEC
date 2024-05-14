# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="Picade-HAT-X"
PKG_VERSION="df02844c0cd773af5b908f47eac5fb1f7f361531"
PKG_ARCH="aarch64"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/pimoroni/picade-hat"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain dtc alsa-lib"
PKG_SECTION="system"
PKG_LONGDESC="Picade-HAT-X: PIMORONI Picade HAT X support"
PKG_TOOLCHAIN="manual"

make_target() {
  dtc -I dts -O dtb -o lakka-driver/picade.dtbo lakka-driver/picade.dts
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/udev/rules.d
    cp -v lakka-driver/10-picade.rules ${INSTALL}/usr/lib/udev/rules.d
  mkdir -p ${INSTALL}/usr/share/bootloader/overlays
    cp -v lakka-driver/picade.dtbo ${INSTALL}/usr/share/bootloader/overlays
}

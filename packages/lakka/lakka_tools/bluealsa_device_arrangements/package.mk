# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="bluealsa_device_arrangements"
PKG_VERSION="1.0"
PKG_ARCH="any"
PKG_DEPENDS_TARGET="toolchain bluez-alsa"
PKG_SECTION="system"
PKG_LONGDESC="bluealsa_device_arrangements: Bluetooth audio output devices arrangements service for BlueALSA"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -pv "${INSTALL}/usr/bin"
    cp -av "${PKG_DIR}/scripts/bluealsa_device_arrangements.sh" "${INSTALL}/usr/bin"
}

post_install() {
  enable_service bluealsa_device_arrangements.service
}

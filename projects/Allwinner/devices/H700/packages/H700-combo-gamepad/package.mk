# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="H700-combo-gamepad"
PKG_VERSION="1.0"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="udev rule to hide the raw gpio-keys-gamepad device on H700 boards where it has been merged into RGxx-combo-gamepad by the h700_combo_gamepad kernel input handler."
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p "${INSTALL}/usr/lib/udev/rules.d"
  cp -Pv "${PKG_DIR}/udev.d/99-RGxx-combo-gamepad.rules" "${INSTALL}/usr/lib/udev/rules.d"
}

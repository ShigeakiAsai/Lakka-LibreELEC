# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="ogu-combo-gamepad"
PKG_VERSION="1.0"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="udev rule to hide the raw ogu-gpio-keys-gamepad device, which is merged into ogu-combo-gamepad by the ogu_combo_gamepad kernel input handler."
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p "${INSTALL}/usr/lib/udev/rules.d"
  cp -Pv "${PKG_DIR}/udev.d/99-ogu-combo-gamepad.rules" "${INSTALL}/usr/lib/udev/rules.d"
}

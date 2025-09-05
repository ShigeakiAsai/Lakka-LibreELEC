# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2025-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="gpicase2_dock_hdmi"
PKG_VERSION="1.0"
PKG_ARCH="aarch64"
PKG_DEPENDS_TARGET="retroarch systemd"
PKG_SECTION="system"
PKG_LONGDESC="Retroflag GPiCASE2 internal LCD and dock HDMI switching script."
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p "${INSTALL}/usr/bin"
    cp -av "${PKG_DIR}/scripts/gpicase2-set-monitor.sh" "${INSTALL}/usr/bin"
}

# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="H700-suspend-resume"
PKG_VERSION="0.1"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_DEPENDS_TARGET="toolchain systemd"
PKG_LONGDESC="H700-suspend-resume: Suspend/resume support for H700 devices (power button suspend, WiFi/RetroArch state handling)."
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p "${INSTALL}/usr/lib/systemd/logind.conf.d"
    cp -av "${PKG_DIR}/logind.conf.d/h700-power-button.conf" "${INSTALL}/usr/lib/systemd/logind.conf.d"

  mkdir -p "${INSTALL}/usr/lib/systemd/system/systemd-suspend.service.d"
    cp -av "${PKG_DIR}/systemd-suspend.service.d/h700-suspend-hooks.conf" "${INSTALL}/usr/lib/systemd/system/systemd-suspend.service.d"

  mkdir -p "${INSTALL}/usr/bin"
    cp -av "${PKG_DIR}/scripts/retroarch-suspend-hook.py" "${INSTALL}/usr/bin"
    cp -av "${PKG_DIR}/scripts/wifi-suspend-hook.sh" "${INSTALL}/usr/bin"
}

# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="S922X-suspend-resume"
PKG_VERSION="0.1"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_DEPENDS_TARGET="toolchain systemd"
PKG_LONGDESC="S922X-suspend-resume: Suspend/resume support for S922X handhelds (power button suspend to s2idle, RetroArch state handling)."
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p "${INSTALL}/usr/lib/systemd/logind.conf.d"
    cp -av "${PKG_DIR}/logind.conf.d/s922x-power-button.conf" "${INSTALL}/usr/lib/systemd/logind.conf.d"

  mkdir -p "${INSTALL}/usr/lib/systemd/sleep.conf.d"
    cp -av "${PKG_DIR}/sleep.conf.d/s922x-suspend-state.conf" "${INSTALL}/usr/lib/systemd/sleep.conf.d"

  mkdir -p "${INSTALL}/usr/lib/tmpfiles.d"
    cp -av "${PKG_DIR}/tmpfiles.d/s922x-mem-sleep.conf" "${INSTALL}/usr/lib/tmpfiles.d"

  mkdir -p "${INSTALL}/usr/lib/systemd/system/systemd-suspend.service.d"
    cp -av "${PKG_DIR}/systemd-suspend.service.d/s922x-suspend-hooks.conf" "${INSTALL}/usr/lib/systemd/system/systemd-suspend.service.d"

  mkdir -p "${INSTALL}/usr/bin"
    cp -av "${PKG_DIR}/scripts/retroarch-suspend-hook.py" "${INSTALL}/usr/bin"
}

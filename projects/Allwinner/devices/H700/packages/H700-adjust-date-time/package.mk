# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2025-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="H700-adjust-date-time"
PKG_VERSION="0.1"
PKG_ARCH="aarch64"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="H700-adjust-date-time: date & time adjust to/from RTC for the ANBERNIC RG 28/34/35/40/Cube XX series"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p "${INSTALL}/usr/bin"
    cp -av "${PKG_DIR}/scripts/adjust-date-time.sh" "${INSTALL}/usr/bin/"
}

post_install() {  
	enable_service H700-adjust-date-time.service
}

# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="evsieve"
PKG_VERSION="ebd7efe1ee902e70c5943b65a2bf44b9a3c31eb8"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/KarsMulder/evsieve"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain cargo:host libevdev"
PKG_LONGDESC="evsieve: A utility for mapping events from Linux event devices."
PKG_TOOLCHAIN="manual"

make_target() {
  cargo build --release --target "${TARGET_NAME}"
}

makeinstall_target() {
  mkdir -p "${INSTALL}/usr/bin"
    cp -av "${PKG_BUILD}/.${TARGET_NAME}/target/${TARGET_NAME}/release/evsieve" "${INSTALL}/usr/bin"
}

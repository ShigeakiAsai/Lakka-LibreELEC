# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2020-present Shanti Gilbert (https://github.com/shantigilbert)
# Copyright (C) 2025-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="H700-hpsense"
PKG_VERSION="0.1"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="H700-hpsense: Change audio output InternalSpeaker/Headphone for the ANBERNIC RG 28/34/35/40/Cube XX series"

post_install() {
  enable_service H700-hpsense.service
}

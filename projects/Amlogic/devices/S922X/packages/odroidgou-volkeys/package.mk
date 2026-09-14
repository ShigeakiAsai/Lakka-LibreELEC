# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="odroidgou-volkeys"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_DEPENDS_TARGET="toolchain eventservice"
PKG_LONGDESC="Service that handlers volume keys in OGU platforms"
PKG_TOOLCHAIN="manual"

post_install() {  
	enable_service odroidgou-volkeys.service
}

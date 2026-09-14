# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2026-present Shanti Gilbert (https://github.com/shantigilbert)

PKG_NAME="odroidgou-utils"
PKG_VERSION="0.1"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Support scripts for the ODROID-GO Ultra"

post_install() {  
	enable_service odroidgou-utils.service
}

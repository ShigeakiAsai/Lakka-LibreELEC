# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2024-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="RK356X-volkeys"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_DEPENDS_TARGET="toolchain eventservice"
PKG_LONGDESC="Service that handlers volume keys in Rockchip RK356X series platforms"
PKG_TOOLCHAIN="manual"

post_install() {  
	enable_service RK356X-volkeys.service
}

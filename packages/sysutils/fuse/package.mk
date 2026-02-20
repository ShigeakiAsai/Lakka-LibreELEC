# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="fuse"
PKG_VERSION="5a43d0f724c56f8836f3f92411e0de1b5f82db32" # 2.9.9+
PKG_SHA256="1df88a204e1673e29112f1ee4efe6b3cd4de2ae78945838e406ead0fe24ec5f1"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libfuse/libfuse/"
PKG_URL="https://github.com/libfuse/libfuse/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
if [ "${PROJECT}" = "L4T" ]; then
  PKG_DEPENDS_INIT="toolchain"
fi
PKG_LONGDESC="FUSE provides a simple interface for userspace programs to export a virtual filesystem to the Linux kernel."
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="MOUNT_FUSE_PATH=/usr/sbin \
                           --enable-lib \
                           --enable-util \
                           --disable-example \
                           --enable-mtab \
                           --disable-rpath \
                           --with-gnu-ld"

if [ "${PROJECT}" = "L4T" ]; then
  PKG_CONFIGURE_OPTS_INIT="MOUNT_FUSE_PATH=/usr/sbin \
                           --enable-lib\
                           --disable-util \
                           --disable-examples \
                           --enable-mtab \
                           --disable-rpath \
                           --with-gnu-ld"
fi

post_makeinstall_target() {
  rm -rf ${INSTALL}/etc/init.d
  rm -rf ${INSTALL}/etc/udev
}

post_makeinstall_init() {
  if [ "${PROJECT}" = "L4T" ]; then
    rm -rf ${INSTALL}/usr/lib/pkgconfig
    rm -rf ${INSTALL}/usr/include
    rm -rf ${INSTALL}/etc/init.d
    rm -rf ${INSTALL}/etc/udev
  fi
}

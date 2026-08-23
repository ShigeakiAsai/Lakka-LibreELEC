# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="lg-gpio"
PKG_VERSION="bcccd782eceedc5b278b3056ea81d5fbbb89c489"
PKG_SHA256="1c1069fe27ccf3d1b2a2f45de10d7bf045206f3bcf60460278a514d4dd223999"
PKG_LICENSE="Unlicense"
PKG_SITE="http://abyz.me.uk/lg/"
PKG_URL="https://github.com/joan2937/lg/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python3 swig:host setuptools:host"
PKG_LONGDESC="A library for Linux Single Board Computers (SBC) which allows control of the General Purpose Input Outputs (GPIO)"
PKG_TOOLCHAIN="manual"

pre_configure_target() {
  export CFLAGS="${CFLAGS} -I${PKG_BUILD}"
  export LDFLAGS="${CFLAGS} -L${PKG_BUILD}"
}

make_target() {
  make liblgpio.so CROSS_PREFIX=${TARGET_PREFIX}
  (
    cd PY_LGPIO
    swig -python lgpio.i
    python_target_env python -m build -n -w -x
  )
}

makeinstall_target() {
  if [ "${DISTRO}" = "Lakka" ]; then
    mkdir -p "${INSTALL}/usr/lib"
    cp -v ./liblgpio.so* "${INSTALL}/usr/lib"
    (
      cd PY_LGPIO
      python_target_env python setup.py install --root=${INSTALL} --prefix=/usr
    )
  fi
}

post_makeinstall_target() {
  if [ "${DISTRO}" = "Lakka" ]; then
    find ${INSTALL}/usr/lib -name "*.py" -exec rm -rf "{}" ";"
    rm -rf ${INSTALL}/usr/bin
  fi
}

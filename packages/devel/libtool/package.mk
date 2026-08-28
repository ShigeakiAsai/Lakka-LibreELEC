# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libtool"
PKG_VERSION="2.6.2"
PKG_SHA256="2ef1067c16c97db930fd740cc9bc3d3ba9a583804ae5ac42cc3e8719e49e191e"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://www.gnu.org/software/libtool/"
PKG_URL="https://ftpmirror.gnu.org/libtool/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_HOST="ccache:host autoconf:host automake:host intltool:host"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A generic library support script."
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_HOST="--enable-static \
                         --disable-shared"

post_unpack() {
  chmod u+w ${PKG_BUILD}/build-aux/ltmain.sh
}

post_patch() {
  # removes previous version files for build error
  if [ -d "${TOOLCHAIN}/share/libtool" ]; then
    rm -rfv "${TOOLCHAIN}/share/libtool"
  fi

  # remove ${TOOLCHAIN}/share/aclocal/lt*.m4 and 
  # ${TOOLCHAIN}/share/aclocal/libtool.m4 if exist
  for f in "${TOOLCHAIN}/share/aclocal/lt"*.m4; do
    [ -e "$f" ] && rm -fv "$f" || true
  done
  [ -f "${TOOLCHAIN}/share/aclocal/libtool.m4" ] && \
    rm -fv "${TOOLCHAIN}/share/aclocal/libtool.m4" || true

  # remove ${SYSROOT_PREFIX}/usr/share/aclocal/lt*.m4 and 
  # ${SYSROOT_PREFIX}/usr/share/aclocal/libtool.m4 if exist
  for f in "${SYSROOT_PREFIX}/usr/share/aclocal/lt"*.m4; do
    [ -e "$f" ] && rm -fv "$f" || true
  done
  [ -f "${SYSROOT_PREFIX}/usr/share/aclocal/libtool.m4" ] && \
    rm -fv "${SYSROOT_PREFIX}/usr/share/aclocal/libtool.m4" || true

  # remove ${TOOLCHAIN}/bin/libtool* if exist
  for f in "${TOOLCHAIN}/bin/libtool"*; do
    [ -e "$f" ] && rm -fv "$f" || true
  done
}

pre_make_host() {
  # do not rebuild man, or txt pages
  touch ${PKG_BUILD}/doc/*.1 \
        ${PKG_BUILD}/doc/*.txt
}

post_makeinstall_target() {
  rm -rf ${INSTALL}/usr/bin
  rm -rf ${INSTALL}/usr/share
}

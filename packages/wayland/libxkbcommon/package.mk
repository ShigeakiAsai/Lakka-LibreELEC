# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libxkbcommon"
PKG_VERSION="1.6.0"
PKG_SHA256="0edc14eccdd391514458bc5f5a4b99863ed2d651e4dd761a90abf4f46ef99c2b"
PKG_LICENSE="MIT"
PKG_SITE="https://xkbcommon.org"
PKG_URL="https://xkbcommon.org/download/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain xkeyboard-config libxml2"
PKG_LONGDESC="xkbcommon is a library to handle keyboard descriptions."

PKG_MESON_OPTS_TARGET="-Denable-docs=false"
if [ "${DISPLAYSERVER}" = "x11" ]; then
  PKG_MESON_OPTS_TARGET+=" -Denable-x11=true \
                           -Denable-wayland=false"
elif [ "${DISPLAYSERVER}" = "wl" ]; then
  PKG_DEPENDS_TARGET+=" wayland wayland-protocols"
  PKG_MESON_OPTS_TARGET+=" -Denable-x11=false \
                           -Denable-wayland=true"
else
  PKG_MESON_OPTS_TARGET+=" -Denable-x11=false \
                           -Denable-wayland=false"
fi

pre_configure_target() {
  if [ "${DISPLAYSERVER}" = "x11" ]; then
    TARGET_LDFLAGS="${LDFLAGS} -lXau -lxcb"
  fi
}

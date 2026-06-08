# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="bluez-alsa"
PKG_VERSION="4.3.1"
PKG_SHA256="933fe898dfac21fdfeb5f4ffa685c2aa2db9c064d639170ac2652f156e956a2a"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/arkq/bluez-alsa"
PKG_URL="${PKG_SITE}/archive/refs/tags/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain m4:host alsa-lib bluez glib sbc fdk-aac libopenaptx libldac lame opus liblc3 ldacBT"
PKG_LONGDESC="Bluetooth Audio ALSA Backend"
PKG_TOOLCHAIN="make"

pre_make_target() {
  autoreconf --install --force

  mkdir -p build
    cd build

  # build parameters info
  #   https://github.com/arkq/bluez-alsa/wiki/Installation-from-source
  ../configure \
    --host="${TARGET_NAME}" \
    --build="${HOST_NAME}" \
    --enable-aac \
    --enable-aptx \
    --enable-aptx-hd \
    --with-libopenaptx \
    --enable-faststream \
    --enable-ldac \
    --enable-mp3lame \
    --disable-mpg123 \
    --enable-opus \
    --enable-lc3-swb \
    --enable-aplay \
    --disable-hcitop \
    --enable-cli \
    --with-alsaplugindir=/usr/lib/alsa \
    --enable-systemd \
    LDFLAGS="-lbluetooth"

  # Drop
  # --enable-lc3plus  [since v4.0.0]
  # --enable-msbc  [since v2.0.0]

  # Disable
  # --enable-mpg123
}

make_target() {
  make clean
  make
}

post_install() {
  enable_service bluealsa.service
  enable_service bluealsa-aplay.service
}

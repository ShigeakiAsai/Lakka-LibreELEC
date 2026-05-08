PKG_NAME="jollycv"
PKG_VERSION="9ceb88e4370b2e04a597b03a9ffe4551c899d6c2"
PKG_LICENSE="BSD-3-Clause"
PKG_SITE="https://github.com/libretro/jollycv"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Jolly Good ColecoVision, CreatiVision, and My Vision Emulator"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C libretro"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v libretro/jollycv_libretro.so ${INSTALL}/usr/lib/libretro/
}

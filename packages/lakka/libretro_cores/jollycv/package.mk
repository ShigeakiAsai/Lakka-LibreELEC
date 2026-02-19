PKG_NAME="jollycv"
PKG_VERSION="5b01c1e43f9040bfae25cc9f9dfb14d73951ec3c"
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

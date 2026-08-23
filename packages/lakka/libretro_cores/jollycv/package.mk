PKG_NAME="jollycv"
PKG_VERSION="eb14292005d51e2bef954cb75145981037ee9988"
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

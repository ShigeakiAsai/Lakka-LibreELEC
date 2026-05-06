PKG_NAME="quicknes"
PKG_VERSION="7848e1ac22b1c69d056ae4cb57710651ff1dd169"
PKG_LICENSE="LGPLv2.1+"
PKG_SITE="https://github.com/libretro/QuickNES_Core"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="The QuickNES core library, originally by Shay Green, heavily modified"
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v quicknes_libretro.so ${INSTALL}/usr/lib/libretro/
}

PKG_NAME="doublecherrygb"
PKG_VERSION="36671c405a017e999581eb56efa6a597cfc14b03"
PKG_LICENSE="AGPLv3"
PKG_SITE="https://github.com/TimOelrichs/doublecherryGB-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="libretro gameboy core with up to 16 players support and buildtin Pokemon Distribution Events - hardfork from tgbdual-libretro"
PKG_TOOLCHAIN="cmake"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v DoubleCherryGB_libretro.so ${INSTALL}/usr/lib/libretro/
}

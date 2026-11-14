PKG_NAME="doublecherrygb"
PKG_VERSION="d432f97693670524f7f46bfca886b731134f4bb6"
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

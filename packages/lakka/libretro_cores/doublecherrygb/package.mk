PKG_NAME="doublecherrygb"
PKG_VERSION="1c42c1bddbe41f79db4ae2db9a959bd73ae6d2bf"
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

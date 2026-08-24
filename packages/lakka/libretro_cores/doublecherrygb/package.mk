PKG_NAME="doublecherrygb"
PKG_VERSION="1587acddb2b575ed2e6c6b1e2c2daaa26bb42134"
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

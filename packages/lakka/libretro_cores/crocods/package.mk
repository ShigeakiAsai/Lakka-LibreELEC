PKG_NAME="crocods"
PKG_VERSION="a9c63b29443715ae2add392010fca4eae7f93e67"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/libretro/libretro-crocods"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Amstrad CPC emulator"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v crocods_libretro.so ${INSTALL}/usr/lib/libretro/
}

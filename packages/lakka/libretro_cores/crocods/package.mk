PKG_NAME="crocods"
PKG_VERSION="87bbb3d9007ac537864278c6c3149ae3291873f8"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/libretro/libretro-crocods"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Amstrad CPC emulator"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v crocods_libretro.so ${INSTALL}/usr/lib/libretro/
}

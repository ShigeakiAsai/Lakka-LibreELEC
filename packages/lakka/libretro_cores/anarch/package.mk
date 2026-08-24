PKG_NAME="anarch"
PKG_VERSION="c0c0b78e5c30644019f7d4fcdddfed4f22db24d7"
PKG_LICENSE="CC0-1.0"
PKG_SITE="https://codeberg.org/iyzsong/anarch-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Anarch, the suckless FPS game, port to libretro."
PKG_TOOLCHAIN="cmake"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ${PKG_BUILD}/.${TARGET_NAME}/anarch_libretro.so ${INSTALL}/usr/lib/libretro/
}

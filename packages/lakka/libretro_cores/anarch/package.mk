PKG_NAME="anarch"
PKG_VERSION="187050344ef440c4eaf3135304a020093564fa3f"
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

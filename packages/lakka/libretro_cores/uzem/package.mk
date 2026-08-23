PKG_NAME="uzem"
PKG_VERSION="d991ee94547c8294abc1c4cb73d63116aa58b5bc"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/libretro/libretro-uzem"
PKG_URL="${PKG_SITE}.git"
PKG_PATCH_DIRS="libretro"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A retro-minimalist game console engine for the ATMega644"
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v uzem_libretro.so ${INSTALL}/usr/lib/libretro/
}

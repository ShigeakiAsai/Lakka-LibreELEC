PKG_NAME="tamalibretro"
PKG_VERSION="bc9a5e6a28758824a90de193f04b32d58b23e3f3"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/celerizer/tamalibretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="TamaLIB Tamagotchi P1 emulator implementation in the libretro API"
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v tamalibretro_libretro.so ${INSTALL}/usr/lib/libretro/
}

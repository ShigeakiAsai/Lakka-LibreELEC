PKG_NAME="bk_emulator"
PKG_VERSION="fe64da42ee463c1b2f4d0566e4d0f7a9667506f6"
PKG_LICENSE="Opensource"
PKG_SITE="https://github.com/libretro/bk-emulator"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC=""
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-f Makefile.libretro"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v bk_libretro.so ${INSTALL}/usr/lib/libretro/
}

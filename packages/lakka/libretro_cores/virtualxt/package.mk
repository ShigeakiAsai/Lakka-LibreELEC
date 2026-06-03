PKG_NAME="virtualxt"
PKG_VERSION="db8e53a3a7b7ff91835841c264acb91cfbd8d401"
PKG_LICENSE="zlib"
PKG_SITE="https://codeberg.org/virtualxt/virtualxt"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Lightweight Turbo PC/XT emulator."
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C tools/package/libretro"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v tools/package/libretro/virtualxt_libretro.so ${INSTALL}/usr/lib/libretro/
}

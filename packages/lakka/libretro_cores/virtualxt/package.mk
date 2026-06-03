PKG_NAME="virtualxt"
PKG_VERSION="1f074e7c3f32d2c523d730d51b9f974c65e530e7"
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

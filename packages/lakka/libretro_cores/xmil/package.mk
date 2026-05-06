PKG_NAME="xmil"
PKG_VERSION="3e7960a433c3bca820f8b8f5511a2b92bd666829"
PKG_LICENSE="GPL3"
PKG_SITE="https://github.com/libretro/xmil-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Libretro port of X Millennium Sharp X1 emulator"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C libretro/ -f Makefile.libretro"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v libretro/x1_libretro.so ${INSTALL}/usr/lib/libretro/
}

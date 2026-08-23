PKG_NAME="2048"
PKG_VERSION="39333f7b13dc4daea7c151d9c38d22b961246343"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/libretro-2048"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Port of 2048 puzzle game to the libretro API."
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-f Makefile.libretro"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v 2048_libretro.so ${INSTALL}/usr/lib/libretro/
}

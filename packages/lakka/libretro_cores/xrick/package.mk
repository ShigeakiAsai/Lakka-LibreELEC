PKG_NAME="xrick"
PKG_VERSION="fcfde3623a04b4e986548e06d46630fcd0bd1e18"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/xrick-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Rick Dangerous Game Engine"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-f Makefile.libretro"

pre_make_target() {
  PKG_MAKE_OPTS_TARGET+=" CC=${CC}"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v xrick_libretro.so ${INSTALL}/usr/lib/libretro/
  mkdir -p ${INSTALL}/usr/share/retroarch/system/xrick
    cp -v data.zip ${INSTALL}/usr/share/retroarch/system/xrick
}

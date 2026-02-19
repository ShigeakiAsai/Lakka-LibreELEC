PKG_NAME="b2"
PKG_VERSION="9793f6a8040c416d147003cada29363b955b54e7"
PKG_LICENSE="GPL-3.0"
PKG_SITE="https://github.com/zoltanvb/b2-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain util-linux"
PKG_LONGDESC="BBC Micro emulator for libretro"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C ../src/libretro"

pre_make_target() {
  CFLAGS+=" -DSYSTEM_HAVE_STRLCPY"
  CXXFLAGS+=" -DSYSTEM_HAVE_STRLCPY"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ${PKG_BUILD}/src/libretro/b2_libretro.so ${INSTALL}/usr/lib/libretro/
}

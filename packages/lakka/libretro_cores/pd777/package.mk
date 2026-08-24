PKG_NAME="pd777"
PKG_VERSION="8c6d1cb4b0d57f14fb7dc18aa37a8aee79c800a3"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/mittonk/PD777"
PKG_URL="${PKG_SITE}.git"
PKG_GIT_CLONE_BRANCH="main"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="PD777 is an Epoch Cassette Vision emulator"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C ../source/libretro -f Makefile.libretro"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ../source/libretro/pd777_libretro.so ${INSTALL}/usr/lib/libretro/
}

PKG_NAME="virtualxt"
PKG_VERSION="36af859a0678990e17e67e32b3115cc48c9293e6"
PKG_LICENSE="zlib"
# temporarily disable on arm because build failure is occurred.
# https://github.com/virtualxt/virtualxt/issues/97
# please enable (remove "!arm" in PKG_ARCH ) when build failure is fixed.
PKG_ARCH="any !arm"
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

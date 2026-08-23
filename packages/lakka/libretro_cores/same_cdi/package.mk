PKG_NAME="same_cdi"
PKG_VERSION="418be509a15342d3fc158a3e83c5b70c7940cd4b"
PKG_LICENSE="MAME"
PKG_SITE="https://github.com/libretro/same_cdi"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="SAME_CDI is a libretro core to play CD-i games. This is a fork and modification of the MAME libretro core"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-f Makefile.libretro platform=unix"

case ${ARCH} in
  x86_64)
    PKG_MAKE_OPTS_TARGET+=" PTR64=1"
    ;;
  i386)
    PKG_MAKE_OPTS_TARGET+=" PTR64=0"
    ;;
  aarch64)
    PKG_MAKE_OPTS_TARGET+=" PTR64=1"
    ;;
  arm)
    PKG_MAKE_OPTS_TARGET+=" PTR64=0"
    ;;
esac

pre_make_target() {
  PKG_MAKE_OPTS_TARGET+=" CC=${CC} CXX=${CXX}"
}

make_target() {
  unset DISTRO
  make ${PKG_MAKE_OPTS_TARGET}
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v same_cdi_libretro.so ${INSTALL}/usr/lib/libretro/
}

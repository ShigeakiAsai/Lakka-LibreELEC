PKG_NAME="snes9x"
PKG_VERSION="fae2fea08f74180759ef540ee94259213f503480"
PKG_LICENSE="Non-commercial"
PKG_SITE="https://github.com/libretro/snes9x"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Snes9x - Portable Super Nintendo Entertainment System (TM) emulator"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C libretro/"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v libretro/snes9x_libretro.so ${INSTALL}/usr/lib/libretro/
}

PKG_NAME="retro8"
PKG_VERSION="95b40e58c29b829d96f37c85833f9e51730c5534"
PKG_LICENSE="GPL3"
PKG_SITE="https://github.com/libretro/retro8"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="PICO-8 implementation"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C ../"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ../retro8_libretro.so ${INSTALL}/usr/lib/libretro/
}

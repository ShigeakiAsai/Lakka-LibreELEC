PKG_NAME="geargrafx"
PKG_VERSION="14b1cda0ba339e5346073a4d9cc47bf4cbaef524"
PKG_LICENSE="GPL-3.0"
PKG_SITE="https://github.com/drhelius/Geargrafx"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="PC Engine / TurboGrafx-16 / SuperGrafx / PCE CD-ROM² emulator"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C platforms/libretro"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v platforms/libretro/geargrafx_libretro.so ${INSTALL}/usr/lib/libretro/
}

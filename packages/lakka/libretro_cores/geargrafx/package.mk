PKG_NAME="geargrafx"
PKG_VERSION="ff264f1e9f9f7244e3ef44ab722d75157d3a5448"
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

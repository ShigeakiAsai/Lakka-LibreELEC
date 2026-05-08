PKG_NAME="neocd"
PKG_VERSION="9e9ad181bed60f84f9cff02c03617b41e8a31cfe"
PKG_LICENSE="LGPLv3"
PKG_SITE="https://github.com/libretro/neocd_libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Neo Geo CD emulator for libretro"
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v neocd_libretro.so ${INSTALL}/usr/lib/libretro/
}

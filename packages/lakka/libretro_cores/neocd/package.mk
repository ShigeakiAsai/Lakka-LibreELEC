PKG_NAME="neocd"
PKG_VERSION="b1e04c738cb48a1dae0574b8877f6a116d270ca1"
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

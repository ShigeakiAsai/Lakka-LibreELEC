PKG_NAME="virtualjaguar"
PKG_VERSION="59f7f9cc594ae6c6982c2bd8fc0dbf36873f9869"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/virtualjaguar-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Port of Virtual Jaguar to Libretro"
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v virtualjaguar_libretro.so ${INSTALL}/usr/lib/libretro/
}

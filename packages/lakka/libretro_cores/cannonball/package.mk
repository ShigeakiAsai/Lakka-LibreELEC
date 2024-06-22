PKG_NAME="cannonball"
PKG_VERSION="c5487ee342ec2596f733a211b812e338cdba8ad8"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/cannonball"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Cannonball: An Enhanced OutRun Engine"
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v cannonball_libretro.so ${INSTALL}/usr/lib/libretro/
  mkdir -p ${INSTALL}/usr/share/retroarch/system/cannonball/res/
    cp -v res/{tilemap.bin,tilepatch.bin} docs/license.txt ${INSTALL}/usr/share/retroarch/system/cannonball/res/
    cp -v roms/roms.txt ${INSTALL}/usr/share/retroarch/system/cannonball/
}

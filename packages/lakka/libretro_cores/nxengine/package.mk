PKG_NAME="nxengine"
PKG_VERSION="fd1c0686f8b4c0aea9b5addbc077e3ad7da23bb7"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/nxengine-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain SDL"
PKG_LONGDESC="Port of NxEngine to libretro - Cave Story game engine clone"
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v nxengine_libretro.so ${INSTALL}/usr/lib/libretro/
  mkdir -p ${INSTALL}/usr/share/retroarch/system/nxengine
    cp -vr datafiles/* ${INSTALL}/usr/share/retroarch/system/nxengine
}

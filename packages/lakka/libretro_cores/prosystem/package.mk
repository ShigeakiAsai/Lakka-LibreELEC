PKG_NAME="prosystem"
PKG_VERSION="363b6dfbd3e240762e022c2b4897b4fe55722be3"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/prosystem-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Port of ProSystem to libretro."
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v prosystem_libretro.so ${INSTALL}/usr/lib/libretro/
}

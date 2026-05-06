PKG_NAME="prosystem"
PKG_VERSION="3f465db9c82fc6764cd90c53fc66eb630e0b3710"
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

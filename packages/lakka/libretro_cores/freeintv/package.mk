PKG_NAME="freeintv"
PKG_VERSION="ef3e0fe322bec62a7f916c0bb0834c08c348d0b4"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/FreeIntv"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="FreeIntv is a libretro emulation core for the Mattel Intellivision."
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v freeintv_libretro.so ${INSTALL}/usr/lib/libretro/
}

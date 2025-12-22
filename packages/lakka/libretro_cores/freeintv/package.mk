PKG_NAME="freeintv"
PKG_VERSION="d29846b67e948e7e2bfe33fe3580cd12e71871c6"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/FreeIntv"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="FreeIntv is a libretro emulation core for the Mattel Intellivision."
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p "${INSTALL}/usr/lib/libretro"
    cp -v FreeIntv_libretro.so "${INSTALL}/usr/lib/libretro/"
}

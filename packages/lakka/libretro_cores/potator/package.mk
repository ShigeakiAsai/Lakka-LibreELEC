PKG_NAME="potator"
PKG_VERSION="735bc376974be564045356188a3b899f2b6fedbd"
PKG_LICENSE="GPL3"
PKG_SITE="https://github.com/libretro/potator"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A Watara Supervision Emulator based on Normmatt version"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C platform/libretro"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v platform/libretro/potator_libretro.so ${INSTALL}/usr/lib/libretro/
}

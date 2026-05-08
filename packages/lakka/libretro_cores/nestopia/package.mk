PKG_NAME="nestopia"
PKG_VERSION="b0fd87dd07e3c52903435d302b04e5e97796f127"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/nestopia"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Libretro implementation of NEStopia. (Nintendo Entertainment System)"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C libretro/"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v libretro/nestopia_libretro.so ${INSTALL}/usr/lib/libretro/
}

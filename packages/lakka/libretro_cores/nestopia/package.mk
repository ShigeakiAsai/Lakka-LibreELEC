PKG_NAME="nestopia"
PKG_VERSION="f1e02d12664834536edbf7352995a3d0cd1caef4"
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

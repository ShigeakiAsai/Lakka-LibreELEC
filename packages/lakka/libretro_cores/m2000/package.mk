PKG_NAME="m2000"
PKG_VERSION="a3ef85a3d68bbe1dc1361a97ff0ad19ec7f50503"
PKG_GIT_CLONE_BRANCH="main"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/p2000t/M2000"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Emulator for the Philips P2000 home computer"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C src/libretro"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v src/libretro/m2000_libretro.so ${INSTALL}/usr/lib/libretro/
}

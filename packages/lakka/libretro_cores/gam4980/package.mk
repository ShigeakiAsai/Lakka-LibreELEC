PKG_NAME="gam4980"
PKG_VERSION="3527822a6bb73bfd336a5f91ee7a772e4e8140a7"
PKG_LICENSE="GPLv3"
PKG_SITE="https://codeberg.org/iyzsong/gam4980"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="This project provides a libretro core to play games from BBK Longman 4980 electronic dictionary."
PKG_TOOLCHAIN="cmake"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v gam4980_libretro.so ${INSTALL}/usr/lib/libretro/
}

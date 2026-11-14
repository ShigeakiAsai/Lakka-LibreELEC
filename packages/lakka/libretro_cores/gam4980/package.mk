PKG_NAME="gam4980"
PKG_VERSION="32c531d3e7159081afd8dee72e8266153821095d"
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

PKG_NAME="gam4980"
PKG_VERSION="df020a0344398ea312604ab8f57016b4c7568024"
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

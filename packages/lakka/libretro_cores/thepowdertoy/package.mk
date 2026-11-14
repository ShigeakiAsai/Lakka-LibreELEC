PKG_NAME="thepowdertoy"
PKG_VERSION="bb2d9f6623d2ccf25a0021045af9591c8a0bbaff"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/ThePowderToy"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A port of The Powder Toy to Libretro"
PKG_TOOLCHAIN="cmake"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v src/thepowdertoy_libretro.so ${INSTALL}/usr/lib/libretro/
}

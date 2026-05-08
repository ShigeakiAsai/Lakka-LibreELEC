PKG_NAME="thepowdertoy"
PKG_VERSION="dcb5e41f1f9800192ea07ea43459413c5a065d9f"
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

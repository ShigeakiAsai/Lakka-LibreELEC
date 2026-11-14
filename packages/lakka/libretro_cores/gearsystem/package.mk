PKG_NAME="gearsystem"
PKG_VERSION="52a93bebe5a123dc58f360ea3e586c4a9dcb2ec0"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/drhelius/Gearsystem"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Gearsystem is a Sega Master System / Game Gear / SG-1000 emulator written in C++"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C platforms/libretro/"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v platforms/libretro/gearsystem_libretro.so ${INSTALL}/usr/lib/libretro/
}


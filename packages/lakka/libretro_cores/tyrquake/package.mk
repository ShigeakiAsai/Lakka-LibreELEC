PKG_NAME="tyrquake"
PKG_VERSION="361d7b46bc75c1c9fb531aefb4329ba66745b540"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/tyrquake"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Libretro port of Tyrquake (Quake 1 engine)"
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v tyrquake_libretro.so ${INSTALL}/usr/lib/libretro/
}

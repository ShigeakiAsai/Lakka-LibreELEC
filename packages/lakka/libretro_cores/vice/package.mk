PKG_NAME="vice"
PKG_VERSION="76cde0b2cc4e52106618f2cc5d9d1112d9205c89"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/vice-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Versatile Commodore 8-bit Emulator version"
PKG_TOOLCHAIN="manual"

make_target() {
  for LRCORE in x64 x128 xpet xplus4 xvic x64dtv x64sc xcbm2 xscpu64 ; do
    make EMUTYPE=${LRCORE}
    make objectclean
  done
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v vice_*_libretro.so ${INSTALL}/usr/lib/libretro/
}

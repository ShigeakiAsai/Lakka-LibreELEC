PKG_NAME="jumpnbump"
PKG_VERSION="25efe413d2159177e54323fb0b9d34966ca019c9"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/jumpnbump-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Port of Jump 'n Bump."

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v jumpnbump_libretro.so ${INSTALL}/usr/lib/libretro/
}

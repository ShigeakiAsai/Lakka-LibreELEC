PKG_NAME="jumpnbump"
PKG_VERSION="2cc840155ce4bf42b2e9e0ef3854b32d534e607e"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/jumpnbump-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Port of Jump 'n Bump."

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v jumpnbump_libretro.so ${INSTALL}/usr/lib/libretro/
}

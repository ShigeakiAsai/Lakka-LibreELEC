PKG_NAME="px68k"
PKG_VERSION="cc45b55983b4d30c961a313a77df9bcf9461dc63"
PKG_LICENSE="Unknown"
PKG_SITE="https://github.com/libretro/px68k-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Portable SHARP X68000 Emulator for PSP, Android and other platforms"
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v px68k_libretro.so ${INSTALL}/usr/lib/libretro/
}

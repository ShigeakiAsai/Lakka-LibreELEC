PKG_NAME="clownmdemu"
PKG_VERSION="004044c2cee2b3e3c7452145a40f7b5ea648d8c4"
PKG_LICENSE="AGPLv3"
PKG_SITE="https://github.com/Clownacy/clownmdemu-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Frontend for ClownMDEmu that exposes it as a libretro core."
PKG_TOOLCHAIN="cmake"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v clownmdemu_libretro.so ${INSTALL}/usr/lib/libretro/
}

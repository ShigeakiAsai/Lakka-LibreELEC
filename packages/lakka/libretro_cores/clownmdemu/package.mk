PKG_NAME="clownmdemu"
PKG_VERSION="64d2df1e434994344963b6347a1f1c171148aad8"
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

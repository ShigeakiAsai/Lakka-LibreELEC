PKG_NAME="clownmdemu"
PKG_VERSION="a6728f34b7e38b3383c62778ba70128d17b09caf"
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

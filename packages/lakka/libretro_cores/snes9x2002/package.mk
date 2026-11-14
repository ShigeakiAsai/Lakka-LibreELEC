PKG_NAME="snes9x2002"
PKG_VERSION="6ffbf9ef4f0063e1f1b78a40d10c50fc52f2524c"
PKG_LICENSE="Non-commercial"
PKG_SITE="https://github.com/libretro/snes9x2002"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Snes9x 2002. Port of SNES9x 1.39 for libretro (was previously called PocketSNES). Heavily optimized for ARM."
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="platform=unix"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v snes9x2002_libretro.so ${INSTALL}/usr/lib/libretro/
}

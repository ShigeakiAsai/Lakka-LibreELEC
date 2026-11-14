PKG_NAME="bsnes_jg"
PKG_VERSION="7ed3cf55cbe3e88414d921db88388ec9e60c6db0"
PKG_LICENSE="GPL-3.0"
PKG_SITE="https://github.com/libretro/bsnes-jg"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="bsnes-jg is a cycle accurate emulator for the Super Famicom/Super Nintendo Entertainment System, including support for the Super Game Boy, BS-X Satellaview, and Sufami Turbo."
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C libretro"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v libretro/bsnes-jg_libretro.so ${INSTALL}/usr/lib/libretro/
}

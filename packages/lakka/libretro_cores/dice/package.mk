PKG_NAME="dice"
PKG_VERSION="f41ed433ed90716521b05437c49684c370faa9df"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/mittonk/dice-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="DICE is a Discrete Integrated Circuit Emulator for games without any type of CPU."
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v dice_libretro.so ${INSTALL}/usr/lib/libretro/
}

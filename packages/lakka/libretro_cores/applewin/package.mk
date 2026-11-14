PKG_NAME="applewin"
PKG_VERSION="e9ebeb7c83b7ffe67d8604a3b79d34925d56aada"
PKG_LICENSE="GPL-2.0"
PKG_SITE="https://github.com/audetto/AppleWin"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Apple II emulator for Linux"
PKG_TOOLCHAIN="cmake"

PKG_CMAKE_OPTS_TARGET="-DBUILD_LIBRETRO=ON"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v source/frontends/libretro/applewin_libretro.so ${INSTALL}/usr/lib/libretro/
}

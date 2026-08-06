PKG_NAME="gearlynx"
PKG_VERSION="17d1c3ddb547099e6a1b03f5f4c32d4ed32faf5f"
PKG_LICENSE="GPL-3.0"
PKG_SITE="https://github.com/drhelius/Gearlynx"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Atari Lynx emulator, debugger, and embedded MCP server"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C platforms/libretro"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v platforms/libretro/gearlynx_libretro.so ${INSTALL}/usr/lib/libretro/
}

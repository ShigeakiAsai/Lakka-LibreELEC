PKG_NAME="chailove"
PKG_VERSION="2e1bad330e9bf4c74c8600ef69648b5c2420d455"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/libretro/libretro-chailove"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain SDL"
PKG_LONGDESC="ChaiLove: 2D Game Framework"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C ../"

makeinstall_target() {
  make -C ../ install INSTALLDIR="${INSTALL}/usr/lib/libretro"
}

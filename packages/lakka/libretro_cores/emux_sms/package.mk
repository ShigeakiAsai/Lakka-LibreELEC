PKG_NAME="emux_sms"
PKG_VERSION="02f7ba42bedad6882ce47f24c8fc3af7eaac79ae"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/emux"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Libretro port of Emux, a cross-platform emulator project supporting various machines with an architecture inspired by the Linux kernel."
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C libretro -f Makefile.lakka MACHINE=sms"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v libretro/emux_sms_libretro.so ${INSTALL}/usr/lib/libretro/
}

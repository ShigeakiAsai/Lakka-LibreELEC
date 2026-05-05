PKG_NAME="amiarcadia"
PKG_VERSION="34af1c9eb71c7ef58e7719e67d77881a99874c36"
PKG_LICENSE="Non-commercial"
PKG_SITE="https://git.libretro.com/libretro/amiarcadia"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A libretro core for emulating Signetics 2650 CPU-based systems, based on DroidArcadia by James Jacobs."
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v amiarcadia_libretro.so ${INSTALL}/usr/lib/libretro/
}

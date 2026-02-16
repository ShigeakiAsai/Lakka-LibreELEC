PKG_NAME="amiarcadia"
PKG_VERSION="4b84422985457b53dcc22ab46f525d7c34d3e51f"
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

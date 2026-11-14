PKG_NAME="kronos"
PKG_VERSION="e21fe2f983165eb80800d1916d59234680ebaa45"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/FCare/Kronos"
PKG_URL="${PKG_SITE}.git"
PKG_ARCH="x86_64"
PKG_DEPENDS_TARGET="toolchain kronos:host"
PKG_DEPENDS_HOST="toolchain:host"
PKG_LONGDESC="Port of Kronos to libretro."
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C yabause/src/libretro platform=unix HAVE_CDROM=1"

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
fi

if [ "${VULKAN_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${VULKAN}"
fi

make_host() {
  make ${PKG_MAKE_OPTS_TARGET} generate-files
}

makeinstall_host() {
 # nothing to do
 :
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v yabause/src/libretro/kronos_libretro.so ${INSTALL}/usr/lib/libretro/
}

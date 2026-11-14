PKG_NAME="vitaquake3"
PKG_VERSION="61374f650f42c4f25c215ea1f8db992af162ada6"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/vitaquake3"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Quake 3 Game Engine"
PKG_TOOLCHAIN="make"

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v vitaquake3_libretro.so ${INSTALL}/usr/lib/libretro/
}

PKG_NAME="vitaquake2"
PKG_VERSION="1fc6922632fe4c5cf44c1a9514fa0d4ef64489c3"
PKG_ARCH="aarch64 x86_64"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/vitaquake2"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Quake II Game Engine"
PKG_TOOLCHAIN="make"

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

if [ "${ARCH}" = "aarch64" ]; then
  if [ "${PROJECT}" = "Allwinner" -a "${DEVICE}" = "H700" ]; then
    PKG_MAKE_OPTS_TARGET+=" GLES=1 GLES31=1 GL_LIB=-lGLESv2"
  fi
fi

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v vitaquake2_libretro.so ${INSTALL}/usr/lib/libretro/
}

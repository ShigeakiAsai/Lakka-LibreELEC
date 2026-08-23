PKG_NAME="mgba_fork"
PKG_VERSION="e31759b24e7a4e3899285ff720d7b573ac328ae7"
PKG_LICENSE="MPLv2.0"
PKG_SITE="https://github.com/libretro/mgba"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="mGBA Game Boy Advance Emulator"
PKG_TOOLCHAIN="cmake"

PKG_CMAKE_OPTS_TARGET="-DCMAKE_BUILD_TYPE=Release \
                       -DBUILD_LIBRETRO=ON \
                       -DSKIP_LIBRARY=ON \
                       -DBUILD_QT=OFF \
                       -DBUILD_SDL=OFF \
                       -DUSE_DISCORD_RPC=OFF \
                       -DUSE_EDITLINE=OFF \
                       -DUSE_EPOXY=OFF \
                       -DUSE_JSON_C=OFF \
                       -DUSE_LUA=OFF \
                       -DUSE_MINIZIP=OFF"

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
  PKG_CMAKE_OPTS_TARGET+=" -DBUILD_GL=ON"
else
  PKG_CMAKE_OPTS_TARGET+=" -DBUILD_GL=OFF"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"

  get_graphicdrivers

  if listcontains "${GRAPHIC_DRIVERS}" "(panfrost|vc4)" && ! listcontains "${MALI_FAMILY}" "t720"; then
    PKG_CMAKE_OPTS_TARGET+=" -DBUILD_GLES3=ON -DBUILD_GLES2=OFF"
  else
    PKG_CMAKE_OPTS_TARGET+=" -DBUILD_GLES3=OFF -DBUILD_GLES2=ON"
  fi
fi

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v "${PKG_BUILD}/.${TARGET_NAME}/mgba_libretro.so" ${INSTALL}/usr/lib/libretro/mgba_fork_libretro.so
}

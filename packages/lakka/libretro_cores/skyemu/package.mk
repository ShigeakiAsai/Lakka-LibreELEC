PKG_NAME="skyemu"
PKG_VERSION="b64903f0fde8104d0796546b96859e9f682311b7"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/skylersaleh/SkyEmu"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Game Boy Advance, Game Boy, Game Boy Color, and DS Emulator"
PKG_TOOLCHAIN="cmake"

PKG_CMAKE_OPTS_TARGET="-DCMAKE_BUILD_TYPE=Release -DRETRO_CORE_ONLY=ON"

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

make_target() {
  cmake --build ${PKG_BUILD}/.${TARGET_NAME} --target skyemu_libretro --config Release -- -j${CONCURRENCY_MAKE_LEVEL:-1}
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v skyemu_libretro.so ${INSTALL}/usr/lib/libretro/
}

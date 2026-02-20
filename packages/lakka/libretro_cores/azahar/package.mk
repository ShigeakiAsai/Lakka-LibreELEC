PKG_NAME="azahar"
PKG_VERSION="f3fb0b729e7ca90e9697ca659643e5ef940ce41d"
PKG_ARCH="x86_64 aarch64"
PKG_LICENSE="GPL-2.0"
PKG_SITE="https://github.com/azahar-emu/azahar"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="An open-source 3DS emulator project based on Citra"
PKG_TOOLCHAIN="cmake"

PKG_CMAKE_OPTS_TARGET="-DENABLE_LIBRETRO=ON -DENABLE_TESTS=OFF"

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
  PKG_CMAKE_OPTS_TARGET+=" -DENABLE_OPENGL=ON"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  PKG_CMAKE_OPTS_TARGET+=" -DENABLE_OPENGL=ON"
fi

if [ "${VULKAN_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${VULKAN}"
  PKG_CMAKE_OPTS_TARGET+=" -DENABLE_VULKAN=ON"
else
  PKG_CMAKE_OPTS_TARGET+=" -DENABLE_VULKAN=OFF"
fi

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v bin/MinSizeRel/azahar_libretro.so ${INSTALL}/usr/lib/libretro/
}

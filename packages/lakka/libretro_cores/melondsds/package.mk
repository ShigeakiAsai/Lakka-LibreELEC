PKG_NAME="melondsds"
PKG_VERSION="bac0256dc6a8736c5a228f57c562257e45fd49f3"
PKG_LICENSE="GPLv3"
PKG_ARCH="aarch64 x86_64"
PKG_SITE="https://github.com/JesseTG/melonds-ds"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A remake of the libretro melonDS core that prioritizes standalone parity, reliability, and usability."
PKG_TOOLCHAIN="cmake"
PKG_BUILD_FLAGS="+lto-off"

PKG_CMAKE_OPTS_TARGET="-DENABLE_JIT=ON -DCMAKE_POLICY_VERSION_MINIMUM=3.5"

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
  PKG_CMAKE_OPTS_TARGET+=" -DENABLE_OPENGL=ON -DENABLE_OPENGLES=OFF"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  PKG_CMAKE_OPTS_TARGET+=" -DENABLE_OPENGL=OFF -DENABLE_OPENGLES=ON"
fi

if [ "${VULKAN_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${VULKAN}"
fi

pre_make_target() {
  find ${PKG_BUILD} -name flags.make -exec sed -i "s:isystem :I:g" \{} \;
  find ${PKG_BUILD} -name build.ninja -exec sed -i "s:isystem :I:g" \{} \;
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v src/libretro/melondsds_libretro.so ${INSTALL}/usr/lib/libretro/
}

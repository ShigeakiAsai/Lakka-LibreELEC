PKG_NAME="ardens"
PKG_VERSION="661a7dd4febc8d00e790a4ecde44b936295adf97"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/tiberiusbrown/Ardens"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A simulator for the Arduboy FX that can be used for profiling and debugging."
PKG_TOOLCHAIN="cmake"

PKG_CMAKE_OPTS_TARGET="-DARDENS_LIBRETRO=on \
                       -DCMAKE_BUILD_TYPE=Release"

pre_make_target() {
  find ${PKG_BUILD} -name flags.make -exec sed -i "s:isystem :I:g" \{} \;
  find ${PKG_BUILD} -name build.ninja -exec sed -i "s:isystem :I:g" \{} \;
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp -v ardens_libretro.so ${INSTALL}/usr/lib/libretro/
}

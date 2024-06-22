PKG_NAME="easyrpg"
PKG_VERSION="f8e41f43b619413f95847536412b56f85307d378"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/EasyRPG/Player"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain zlib libfmt liblcf pixman speexdsp mpg123 libsndfile libvorbis opusfile wildmidi libxmp-lite libpng fluidsynth"
PKG_LONGDESC="An unofficial libretro port of the EasyRPG/Player."
PKG_TOOLCHAIN="cmake"
PKG_BUILD_FLAGS="+pic"
PKG_LR_UPDATE_TAG="yes"

PKG_CMAKE_OPTS_TARGET="-DPLAYER_TARGET_PLATFORM=libretro \
                       -DPLAYER_WITH_FREETYPE=OFF \
                       -DBUILD_SHARED_LIBS=ON \
                       -DCMAKE_BUILD_TYPE=Release"

pre_make_taget() {
  find ${PKG_BUILD} -name flags.make -exec sed -i "s:isystem :I:g" \{} \;
  find ${PKG_BUILD} -name build.ninja -exec sed -i "s:isystem :I:g" \{} \;
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ${PKG_BUILD}/.${TARGET_NAME}/easyrpg_libretro.so ${INSTALL}/usr/lib/libretro/
}

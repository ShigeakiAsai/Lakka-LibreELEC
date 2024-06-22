PKG_NAME="liblcf"
PKG_VERSION="9c09529e3de0a4106470082ef48a00d4c3593c33"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/EasyRPG/liblcf"
PKG_URL="${PKG_SITE}/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain expat icu"
PKG_SECTION="devel"
PKG_LONGDESC="Library to handle RPG Maker 2000/2003 and EasyRPG projects"
PKG_TOOLCHAIN="cmake"

PKG_CMAKE_OPTS_TARGET="-DCMAKE_BUILD_TYPE=Release"

pre_make_target() {
  find ${PKG_BUILD} -name flags.make -exec sed -i "s:isystem :I:g" \{} \;
  find ${PKG_BUILD} -name build.ninja -exec sed -i "s:isystem :I:g" \{} \;
}

PKG_NAME="opusfile"
PKG_VERSION="0.12"
PKG_SHA256="a20a1dff1cdf0719d1e995112915e9966debf1470ee26bb31b2f510ccf00ef40"
PKG_LICENSE="BSD-3c"
PKG_SITE="https://github.com/xiph/opusfile"
PKG_URL="${PKG_SITE}/archive/refs/tags/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain openssl opus"
PKG_LONGDESC="Stand-alone decoder library for .opus streams"
PKG_TOOLCHAIN="configure"
PKG_BUILD_FLAGS="+pic"

pre_configure_target() {
  cd ${PKG_BUILD}
  if [ -f autogen.sh ]; then
    ./autogen.sh
  else
    make distclean
    ./autogen.sh
  fi
}

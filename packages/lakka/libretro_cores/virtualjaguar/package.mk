PKG_NAME="virtualjaguar"
PKG_VERSION="8c758ff6cc49b0fefaf30ce5b80645ca754a54eb"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/virtualjaguar-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Port of Virtual Jaguar to Libretro"
PKG_TOOLCHAIN="make"

pre_make_target() {
  case "${TARGET_NAME}" in
    armv6*)
      PKG_MAKE_OPTS_TARGET="ARCH=arm"
      ;;
    armv7*|armv8*)
      PKG_MAKE_OPTS_TARGET="ARCH=arm HAVE_NEON=1"
      ;;
  esac
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v virtualjaguar_libretro.so ${INSTALL}/usr/lib/libretro/
}

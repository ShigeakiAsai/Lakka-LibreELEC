PKG_NAME="amiberry"
PKG_VERSION="5a70ab7d579a1b29e7fb9bb8276021fcd81d413c"
PKG_ARCH="aarch64 arm x86_64"
PKG_GIT_CLONE_BRANCH="libretro-core"
PKG_LICENSE="GPL-3.0"
PKG_SITE="https://github.com/BlitterStudio/amiberry"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain zlib aros68kroms"
PKG_LONGDESC="Optimized Amiga emulator for Linux/macOS"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C ../libretro"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ${PKG_BUILD}/libretro/amiberry_libretro.so ${INSTALL}/usr/lib/libretro/

  # copy run-time files to RetroArch system folder
  mkdir -p ${INSTALL}/usr/share/retroarch/system/whdboot
    cp -vr ${PKG_BUILD}/whdboot/{game,save}-data ${INSTALL}/usr/share/retroarch/system/whdboot
    unzip ${PKG_BUILD}/whdboot/boot-data.zip -d ${INSTALL}/usr/share/retroarch/system/whdboot/save-data

  # copy info file, as it is not yet in upstream
  cp -v ${PKG_DIR}/files/amiberry_libretro.info ${INSTALL}/usr/lib/libretro
}

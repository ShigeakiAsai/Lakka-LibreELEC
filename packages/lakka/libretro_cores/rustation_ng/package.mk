PKG_NAME="rustation_ng"
PKG_VERSION="59f50942f1c39d978602f8e8382a01b46d537a9f"
PKG_ARCH="any !i386"
PKG_LICENSE="GPL-2.0"
PKG_SITE="https://gitlab.com/flio/rustation-ng"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain cargo:host"
PKG_LONGDESC="Libretro implementation for the rustation emulator"
PKG_TOOLCHAIN="manual"

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

make_target() {
	 cargo build --release --target ${TARGET_NAME}
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ${PKG_BUILD}/.${TARGET_NAME}/target/${TARGET_NAME}/release/librustation_ng_retro.so ${INSTALL}/usr/lib/libretro/rustation_ng_libretro.so
    cp -v ${PKG_BUILD}/librustation_ng.info ${INSTALL}/usr/lib/libretro/rustation_ng_libretro.info
}

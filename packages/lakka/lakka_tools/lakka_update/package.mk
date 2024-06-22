PKG_NAME="lakka_update"
PKG_VERSION="0"
PKG_LICENSE="GPL"
PKG_LONGDESC="Shell script to wget the latest update"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
    cp -v lakka-update.sh ${INSTALL}/usr/bin/lakka-update
    chmod -v +x ${INSTALL}/usr/bin/lakka-update
    sed -e "s|@LAKKA_UPDATE_SERVER_URL@|${LAKKA_UPDATE_SERVER_URL}|" \
        -e "s|@LAKKA_TARGET_DEVICE_ARCH@|${DEVICE:-${PROJECT}}.${ARCH}|" \
        -i ${INSTALL}/usr/bin/lakka-update
}

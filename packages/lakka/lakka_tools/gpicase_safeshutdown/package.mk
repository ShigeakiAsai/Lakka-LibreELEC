PKG_NAME="gpicase_safeshutdown"
PKG_VERSION="1.0"
PKG_ARCH="arm aarch64"
if [ "${DEVICE}" != "RPi4-GPiCase2" ]; then
  # for RPiZero-GPiCase & RPiZero2-GPiCase & RPiZero2-GPiCase2W
  PKG_DEPENDS_TARGET="Python3 gpiozero colorzero"
else
  # for RPi4-GPiCase2
  PKG_DEPENDS_TARGET="Python3 lg-gpio"
fi
PKG_SECTION="system"
PKG_LONGDESC="GPICase safe shutdown script."
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
    cp -v ${PKG_DIR}/scripts/* ${INSTALL}/usr/bin
}

post_install() {
  if [ "${DEVICE}" != "RPi4-GPiCase2" ]; then
    # for RPiZero-GPiCase & RPiZero2-GPiCase & RPiZero2-GPiCase2W
    enable_service gpicase-safeshutdown.service
    rm -v ${INSTALL}/usr/bin/safeshutdown_gpicase2.py
    rm -v ${INSTALL}/usr/lib/systemd/system/gpicase2-safeshutdown.service
  else
    # for RPi4-GPiCase2
    enable_service gpicase2-safeshutdown.service
    rm -v ${INSTALL}/usr/bin/safeshutdown_gpi.py
    rm -v ${INSTALL}/usr/lib/systemd/system/gpicase-safeshutdown.service
  fi
}

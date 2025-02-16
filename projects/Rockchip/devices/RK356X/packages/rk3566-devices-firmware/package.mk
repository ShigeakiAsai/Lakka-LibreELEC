# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2024-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="rk3566-devices-firmware"
PKG_VERSION="800cc6483d3f04ff4eda610ab60dcf25c832eaee"
PKG_SITE="https://github.com/armbian/firmware"
PKG_URL="${PKG_SITE}/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="rk3566-devices-firmware: RK3566 devices wifi & bluetooth firmware files"
PKG_TOOLCHAIN="manual"

pre_makeinstall_target() {
  # For Orange Pi 3B wifi firmware
  cp -av "${PKG_BUILD}/brcm/brcmfmac43456-sdio.bin" "${PKG_BUILD}/brcm/brcmfmac43456-sdio.xunlong,orangepi-3b.bin"
  cp -av "${PKG_BUILD}/brcm/brcmfmac43456-sdio.txt" "${PKG_BUILD}/brcm/brcmfmac43456-sdio.xunlong,orangepi-3b.txt"
  cp -av "${PKG_BUILD}/brcm/brcmfmac43456-sdio.bin" "${PKG_BUILD}/brcm/brcmfmac43456-sdio.xunlong,orangepi-3b-v1.1.bin"
  cp -av "${PKG_BUILD}/brcm/brcmfmac43456-sdio.txt" "${PKG_BUILD}/brcm/brcmfmac43456-sdio.xunlong,orangepi-3b-v1.1.txt"
  cp -av "${PKG_BUILD}/brcm/brcmfmac43456-sdio.bin" "${PKG_BUILD}/brcm/brcmfmac43456-sdio.xunlong,orangepi-3b-v2.1.bin"
  cp -av "${PKG_BUILD}/brcm/brcmfmac43456-sdio.txt" "${PKG_BUILD}/brcm/brcmfmac43456-sdio.xunlong,orangepi-3b-v2.1.txt"
}

makeinstall_target() {
  # For Orange Pi 3B wifi firmware
  mkdir -pv "${INSTALL}/$(get_kernel_overlay_dir)/lib/firmware/brcm"
    cp -av "${PKG_BUILD}/brcm/brcmfmac43456-sdio.xunlong,orangepi-3b.bin" "${INSTALL}/$(get_kernel_overlay_dir)/lib/firmware/brcm/"
    cp -av "${PKG_BUILD}/brcm/brcmfmac43456-sdio.xunlong,orangepi-3b.txt" "${INSTALL}/$(get_kernel_overlay_dir)/lib/firmware/brcm/"
    cp -av "${PKG_BUILD}/brcm/brcmfmac43456-sdio.xunlong,orangepi-3b-v1.1.bin" "${INSTALL}/$(get_kernel_overlay_dir)/lib/firmware/brcm/"
    cp -av "${PKG_BUILD}/brcm/brcmfmac43456-sdio.xunlong,orangepi-3b-v1.1.txt" "${INSTALL}/$(get_kernel_overlay_dir)/lib/firmware/brcm/"
    cp -av "${PKG_BUILD}/brcm/brcmfmac43456-sdio.xunlong,orangepi-3b-v2.1.bin" "${INSTALL}/$(get_kernel_overlay_dir)/lib/firmware/brcm/"
    cp -av "${PKG_BUILD}/brcm/brcmfmac43456-sdio.xunlong,orangepi-3b-v2.1.txt" "${INSTALL}/$(get_kernel_overlay_dir)/lib/firmware/brcm/"
    cp -av "${PKG_BUILD}/brcm/brcmfmac43456-sdio.clm_blob" "${INSTALL}/$(get_kernel_overlay_dir)/lib/firmware/brcm/"

  # For ANBERNIC AG ARC D / POWKIDDY RGB10 MAX3 bluetooth firmware
  mkdir -pv "${INSTALL}/$(get_kernel_overlay_dir)/lib/firmware/rtl_bt"
    cp -av "${PKG_BUILD}/rtl_bt/rtl8723ds_fw.bin" "${INSTALL}/$(get_kernel_overlay_dir)/lib/firmware/rtl_bt/"
    cp -av "${PKG_BUILD}/rtl_bt/rtl8723ds_config.bin" "${INSTALL}/$(get_kernel_overlay_dir)/lib/firmware/rtl_bt/"
}

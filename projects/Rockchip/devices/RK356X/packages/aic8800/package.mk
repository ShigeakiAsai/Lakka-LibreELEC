# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2024-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="aic8800"
PKG_VERSION="3.0+git20240327.3561b08f-2"
PKG_SITE="https://github.com/radxa-pkg/${PKG_NAME}"
PKG_URL="${PKG_SITE}/archive/refs/tags/${PKG_VERSION}.tar.gz"
PKG_LONGDESC="Aicsemi aic8800 Wi-Fi driver & frimware"
PKG_TOOLCHAIN="manual"
PKG_IS_KERNEL_PKG="yes"

pre_make_target() {
  unset LDFLAGS
  patch -p1 < ./debian/patches/fix-linux-6.1-build.patch
  patch -p1 < ./debian/patches/fix-linux-6.5-build.patch
  patch -p1 < ./debian/patches/fix-linux-6.7-build.patch
  patch -p1 < ./debian/patches/fix-linux-6.9-build.patch
  patch -p1 < ./debian/patches/fix-linux-6.12-build.patch
  patch -p1 < ./debian/patches/fix-sdio-firmware-path.patch
}

make_target() {
  # PCIE
  # kernel_make -C $(kernel_path) M="${PKG_BUILD}/src/PCIE/driver_fw/driver/${PKG_NAME}" modules

  # SDIO
  kernel_make -C $(kernel_path) M="${PKG_BUILD}/src/SDIO/driver_fw/driver/${PKG_NAME}" modules

  # USB
  # kernel_make -C $(kernel_path) M="${PKG_BUILD}/src/USB/driver_fw/driver/${PKG_NAME}" modules
}

makeinstall_target() {
  mkdir -p "${INSTALL}/$(get_full_module_dir)/${PKG_NAME}/"
    cp -av ./src/SDIO/driver_fw/driver/aic8800/aic8800_bsp/*.ko "${INSTALL}/$(get_full_module_dir)/${PKG_NAME}/"
    cp -av ./src/SDIO/driver_fw/driver/aic8800/aic8800_btlpm/*.ko "${INSTALL}/$(get_full_module_dir)/${PKG_NAME}/"
    cp -av ./src/SDIO/driver_fw/driver/aic8800/aic8800_fdrv/*.ko "${INSTALL}/$(get_full_module_dir)/${PKG_NAME}/"

  # PCIE firmware
  # mkdir -p "${INSTALL}/$(get_full_firmware_dir)/aic8800_fw/PCIE/"
  #   cp -av ./src/PCIE/driver_fw/fw/* "${INSTALL}/$(get_full_firmware_dir)/aic8800_fw/PCIE/"

  # SDIO firmware
  mkdir -p "${INSTALL}/$(get_full_firmware_dir)/aic8800_fw/SDIO/"
    cp -av ./src/SDIO/driver_fw/fw/* "${INSTALL}/$(get_full_firmware_dir)/aic8800_fw/SDIO/"

  # USB firmware
  # mkdir -p "${INSTALL}/$(get_full_firmware_dir)/aic8800_fw/USB/aic8800D80/"
  #   cp -av ./src/USB/driver_fw/fw/* "${INSTALL}/$(get_full_firmware_dir)/aic8800_fw/USB/"
  #   cp -av ./debian/patches/fmacfw_8800d80_u02.bin "${INSTALL}/$(get_full_firmware_dir)/aic8800_fw/USB/aic8800D80/"
}

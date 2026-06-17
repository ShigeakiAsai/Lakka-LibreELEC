# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="LakkaSimpleClock"
PKG_VERSION="0.1"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_DEPENDS_TARGET="toolchain retroarch"
PKG_LONGDESC="LakkaSimpleClock: Simple clock for no network devices"
PKG_TOOLCHAIN="manual"

pre_make_target() {
  echo "Starting Lakka Clock Asset Pipeline: Compiling Lakka.png into the source header..."
  
  local SCRIPT_PATH="${PKG_DIR}/assets/png_to_header.py"
  local INPUT_IMAGE_DIR="${DISTRO_DIR}/Lakka"
  local OUTPUT_HEADER_DIR="${PKG_BUILD}"
  
  python3 "${SCRIPT_PATH}" "${INPUT_IMAGE_DIR}" "${OUTPUT_HEADER_DIR}"
  
  if [ -f "${PKG_BUILD}/lakka_logo_res.h" ]; then
    echo "Asset compiled cleanly into the target source tree: lakka_logo_res.h created."
  else
    echo "Fatal Error: Asset compiler failed to generate resource header."
    return 1
  fi
}

make_target() {
  cd "${PKG_BUILD}"
    make clean
    make platform=unix
}

makeinstall_target() {
  mkdir -pv "${INSTALL}/usr/lib/libretro"
    cp -av "${PKG_BUILD}/lakkasimpleclock_libretro.so" "${INSTALL}/usr/lib/libretro/"
}

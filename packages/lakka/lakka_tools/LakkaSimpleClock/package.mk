# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="LakkaSimpleClock"
PKG_VERSION="0.4"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_DEPENDS_TARGET="toolchain retroarch"
PKG_LONGDESC="LakkaSimpleClock: Simple clock for no network devices"
PKG_TOOLCHAIN="manual"

if [ "${DEVICE}" = "Switch" ]; then
   PKG_DEPENDS_TARGET+=" dbus"
fi

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

   if [ "${DEVICE}" = "Switch" ]; then
      echo "Building for Nintendo Switch with native D-Bus integration..."
      make platform=unix \
           REAL_CFLAGS="-D__SWITCH__ \$(shell pkg-config --cflags dbus-1) \$(CFLAGS) -fpic -O2 -Wall -I." \
           REAL_LDFLAGS="\$(LDFLAGS) -ldbus-1 -lm"
   else
      make platform=unix
   fi
}

makeinstall_target() {
   mkdir -pv "${INSTALL}/usr/lib/libretro"
   cp -av "${PKG_BUILD}/lakkasimpleclock_libretro.so" "${INSTALL}/usr/lib/libretro/"
}

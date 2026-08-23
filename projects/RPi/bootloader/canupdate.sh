#!/bin/sh

# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

# Allow upgrades between arm and aarch64
if [ "${1}" = "@PROJECT@.arm" -o "${1}" = "@PROJECT@.aarch64" ]; then
  exit 0
# Allow upgrade from GPICase.arm to RPiZero-GPiCase.arm
elif [ "${1}" = "GPICase.arm" -a "${2}" = "RPiZero-GPiCase.arm" ]; then
  exit 0
# Allow upgrade from Pi02GPi.arm to RPiZero2-GPiCase.arm
elif [ "${1}" = "Pi02GPi.arm" -a "${2}" = "RPiZero2-GPiCase.arm" ]; then
  exit 0
# Allow upgrade from RPiZero2-GPiCASE2W.aarch64 to RPiZero2-GPiCase2W.aarch64
elif [ "${1}" = "RPiZero2-GPiCASE2W.aarch64" -a "${2}" = "RPiZero2-GPiCase2W.aarch64" ]; then
  exit 0
# Allow upgrade from RPi4-GPICase2.aarch64 to RPi4-GPiCase2.aarch64
elif [ "${1}" = "RPi4-GPICase2.aarch64" -a "${2}" = "RPi4-GPiCase2.aarch64" ]; then
  exit 0
else
  exit 1
fi

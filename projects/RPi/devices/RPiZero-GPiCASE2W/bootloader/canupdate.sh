# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

# Allow upgrades from GPICase.arm to RPiZero-GPiCASE2W.arm
if [ "$1" = "GPICase.arm" -o "$1" = "GPICase.arm" ]; then
  exit 0
else
  exit 1
fi

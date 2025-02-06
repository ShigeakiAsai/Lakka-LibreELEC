# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2024-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="flit"
PKG_VERSION="3.10.1"
PKG_SHA256="66e5b87874a0d6e39691f0e22f09306736b633548670ad3c09ec9db03c5662f7"
PKG_LICENSE="BSD"
PKG_SITE="https://pypi.org/project/flit-core/"
PKG_URL="https://files.pythonhosted.org/packages/source/f/flit_core/flit_core-${PKG_VERSION}.tar.gz"
PKG_SOURCE_DIR="flit_core-${PKG_VERSION}"
PKG_DEPENDS_HOST="Python3:host"
PKG_LONGDESC="flit provides a PEP 517 build backend for packages using Flit."
PKG_TOOLCHAIN="manual"

make_host() {
  export DONT_BUILD_LEGACY_PYC=1
  python3 -m flit_core.wheel
}

makeinstall_host() {
  exec_thread_safe python3 -m bootstrap_install dist/*.whl --installdir=${TOOLCHAIN}/lib/${PKG_PYTHON_VERSION}/site-packages
}

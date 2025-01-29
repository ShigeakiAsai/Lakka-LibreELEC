# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="Jinja2"
PKG_VERSION="3.1.5"
PKG_SHA256="8fefff8dc3034e27bb80d67c671eb8a9bc424c0ef4c0826edbff304cceff43bb"
PKG_LICENSE="BSD"
PKG_SITE="https://pypi.org/project/Jinja2/"
PKG_URL="https://files.pythonhosted.org/packages/source/${PKG_NAME:0:1}/${PKG_NAME}/${PKG_NAME,,}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="Python3:host setuptools:host MarkupSafe:host"
PKG_LONGDESC="Jinja is a fast, expressive, extensible templating engine."
PKG_TOOLCHAIN="python"

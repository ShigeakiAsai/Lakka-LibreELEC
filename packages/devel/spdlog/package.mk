# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="spdlog"
PKG_VERSION="1.15.1"
PKG_SHA256="25c843860f039a1600f232c6eb9e01e6627f7d030a2ae5e232bdd3c9205d26cc"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/gabime/spdlog"
PKG_URL="https://github.com/gabime/spdlog/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libfmt"
PKG_LONGDESC="Very fast, header only, C++ logging library."

PKG_CMAKE_OPTS_TARGET="-DCMAKE_CXX_STANDARD=14 \
                       -DCMAKE_CXX_EXTENSIONS:BOOL=OFF \
                       -DSPDLOG_BUILD_SHARED=ON \
                       -DSPDLOG_FMT_EXTERNAL=ON \
                       -DSPDLOG_BUILD_EXAMPLE=OFF \
                       -DSPDLOG_BUILD_TESTS=OFF"

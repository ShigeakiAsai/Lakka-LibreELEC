# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="aspnet8-runtime"
PKG_VERSION="8.0.13"
PKG_LICENSE="MIT"
PKG_SITE="https://dotnet.microsoft.com/"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="ASP.NET Core Runtime enables you to run existing web/server applications."
PKG_TOOLCHAIN="manual"

case "${ARCH}" in
  "aarch64")
    PKG_SHA256="e9dd3204feac0e7e127a1a8be9e20ae7280d19f7c2720e5fafafa926cb51963c"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/3167f98c-e2ef-4d19-bd00-178c27ed7f3d/8f9eb25b9899009f11ae837612b52c0e/aspnetcore-runtime-8.0.13-linux-arm64.tar.gz"
    ;;
  "arm")
    PKG_SHA256="18cd7094db1b59b5c58b4fbce333f85a41c75f1bb8e23fc2a6d8df1524e05b66"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/2c764efa-2f8b-44d1-9308-87dcafaeff2f/cd8f6383aa8adb1dd9493520b57f08ef/aspnetcore-runtime-8.0.13-linux-arm.tar.gz"
    ;;
  "x86_64")
    PKG_SHA256="b438f4e8f5f23b247ad56146505ce853bb09505b9af8294d0293bfce806663da"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/2115caf0-c47f-448a-8ad6-107a742d2b9e/52036588ffe8f8abd87a3d033fd93b67/aspnetcore-runtime-8.0.13-linux-x64.tar.gz"
    ;;
esac
PKG_SOURCE_NAME="aspnetcore-runtime_${PKG_VERSION}_${ARCH}.tar.gz"

PKG_NAME="vk_layer_tegra_x11_present"
PKG_VERSION="ebee69459788aff5a8d51a9d0558669c15ac6536"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/GavinDarkglider/vk_layer_tegra_x11_present"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain tegra-bsp vulkan-loader xorg-server"
PKG_LONGDESC="Vulkan layer to fix tearing issues"
PKG_TOOLCHAIN="make"


PKG_MAKEINSTALL_OPTS_TARGET="LAYERLIBDIR=/usr/lib LAYERJSONDIR=/etc/vulkan/implicit_layer.d"

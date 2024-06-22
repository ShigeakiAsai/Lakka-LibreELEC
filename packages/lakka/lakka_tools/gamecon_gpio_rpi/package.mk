PKG_NAME="gamecon_gpio_rpi"
PKG_VERSION="26b61caea841dacc1f57587f655288d39f3ffedc"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/h1aji/gamecon_gpio_rpi"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="${LINUX_DEPENDS}"
PKG_LONGDESC="Gamecon GPIO rpi joystick driver"
PKG_TOOLCHAIN="manual"
PKG_IS_KERNEL_PKG="yes"

pre_make_target() {
  unset LDFLAGS
}

make_target() {
  kernel_make KDIR=$(kernel_path) \
        -C $(kernel_path) M=${PKG_BUILD} modules
}

makeinstall_target() {
  mkdir -p ${INSTALL}/$(get_full_module_dir)/${PKG_NAME}
  cp -v ${PKG_BUILD}/*.ko ${INSTALL}/$(get_full_module_dir)/${PKG_NAME}
}

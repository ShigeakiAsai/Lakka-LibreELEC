PKG_NAME="RTL88x2BU"
PKG_VERSION="620b1a12c8822ee7d340465fbdc9d5150b193189"
PKG_LICENSE="GPL-2.0"
PKG_SITE="https://www.wolfteck.com/2018/02/22/wsky_1200mbps_wireless_usb_wifi_adapter/"
PKG_URL="https://github.com/cilynx/rtl88x2bu.git"
PKG_LONGDESC="Driver for rtl88x2bu wifi adaptors"
PKG_TOOLCHAIN="make"
PKG_IS_KERNEL_PKG="yes"


pre_make_target() {
  unset LDFLAGS
}

make_target() {
  make V=1 \
       ARCH=${TARGET_KERNEL_ARCH} \
       KSRC=$(kernel_path) \
       CROSS_COMPILE=${TARGET_KERNEL_PREFIX} \
       CONFIG_POWER_SAVING=n
}

makeinstall_target() {
  mkdir -p ${INSTALL}/$(get_full_module_dir)/${PKG_NAME}
    cp *.ko ${INSTALL}/$(get_full_module_dir)/${PKG_NAME}
}


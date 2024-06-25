PKG_NAME="ddccontrol"
PKG_VERSION="1.0.3"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/ddccontrol/ddccontrol"
PKG_URL="${PKG_SITE}/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libxml2"
PKG_LONGDESC="DDC/CI control"
PKG_TOOLCHAIN="make"

pre_configure() {
  ./autogen.sh
}

configure_target() {
  ./configure --host="${TARGET_NAME}" \
              --build=${HOST_NAME} \
              --disable-ddcpci \
              --disable-gnome \
              --prefix=/usr \
              --sysconfdir=/etc \
              --libexecdir=/usr/lib
}

makeinstall_target() {
  make install DESTDIR=${INSTALL}
}

#post_install() {
#  enable_service cec-mini-kb.service
#}

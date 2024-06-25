PKG_NAME="ddccontrol-db"
PKG_VERSION="20240304"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/ddccontrol/ddccontrol-db"
PKG_URL="${PKG_SITE}/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libxml2 ddccontrol"
PKG_LONGDESC="DDC/CI control database"
PKG_TOOLCHAIN="make"

pre_configure() {
  ./autogen.sh
}

configure_target() {
  ./configure --host="${TARGET_NAME}" \
              --build=${HOST_NAME} \
              --prefix=/usr
#              --disable-ddcpci \
#              --disable-gnome \
#              --prefix=/usr \
#              --sysconfdir=/etc \
#              --libexecdir=/usr/lib
}

makeinstall_target() {
  make install DESTDIR=${INSTALL}
}

#post_install() {
#  enable_service cec-mini-kb.service
#}

PKG_NAME="retrorama_theme_xmb"
PKG_VERSION="b2877609d9ab39df1f6b1a23bb3a23e8cb446b76"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/lipebello/Retroarch-XMB-Retrorama-Theme"
PKG_URL="${PKG_SITE}.git"
PKG_LONGDESC="Retrorama Theme for Retroarch XMB UI"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/share/retroarch/assets/{xmb/custom,wallpapers}
    cp -vr Retrorama/font.ttf Retrorama/png ${INSTALL}/usr/share/retroarch/assets/xmb/custom
    cp -vr "Retrorama Dynamic Wallpapers" ${INSTALL}/usr/share/retroarch/assets/wallpapers
}

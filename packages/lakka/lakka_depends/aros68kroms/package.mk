PKG_NAME="aros68kroms"
PKG_VERSION="1.0"
PKG_LICENSE="AROS"
PKG_SITE="https://aros.sourceforge.io"
PKG_LONGDESC="Redistributable AROS 68k Kickstart-compatible ROMs for Amiga emulators"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/share/retroarch/system
    cp -v ${PKG_DIR}/files/aros-amiga-m68k-rom.bin ${INSTALL}/usr/share/retroarch/system/kick31.rom
    cp -v ${PKG_DIR}/files/aros-amiga-m68k-ext.bin ${INSTALL}/usr/share/retroarch/system/kick31.ext
}

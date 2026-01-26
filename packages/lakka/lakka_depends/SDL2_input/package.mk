PKG_NAME="SDL2_input"
PKG_VERSION="2.32.10"
PKG_SHA256="5f5993c530f084535c65a6879e9b26ad441169b3e25d789d83287040a9ca5165"
PKG_LICENSE="ZLIB"
PKG_SITE="https://www.libsdl.org"
PKG_URL="https://www.libsdl.org/release/SDL2-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain dbus libusb systemd"
PKG_LONGDESC="SDL2 built with only input subsystems for RetroArch"
PKG_TOOLCHAIN="configure"
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_TARGET="--disable-static --enable-shared \
                           --disable-render \
                           --disable-audio \
                           --disable-power \
                           --disable-filesystem \
                           --disable-timers \
                           --enable-loadso \
                           --enable-joystick \
                           --enable-haptic \
                           --enable-sensor \
                           --enable-hidapi \
                           --enable-hidapi-libusb \
                           --enable-hidapi-joystick"

if [ "${DISPLAYSERVER}" = "x11" ]; then
  PKG_CONFIGURE_OPTS_TARGET+=" --enable-video-x11 --enable-x11-shared"
  PKG_DEPENDS_TARGET+=" libX11 libXcursor libXext libXfixes libXi libXrandr libXrender"
else
  PKG_CONFIGURE_OPTS_TARGET+=" --disable-video"
fi

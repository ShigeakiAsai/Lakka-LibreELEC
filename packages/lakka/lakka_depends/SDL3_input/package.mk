PKG_NAME="SDL3_input"
PKG_VERSION="3.4.10"
PKG_SHA256="12b34280415ec8418c864408b93d008a20a6530687ee613d60bfbd20411f2785"
PKG_LICENSE="ZLIB"
PKG_SITE="https://www.libsdl.org"
PKG_URL="https://www.libsdl.org/release/SDL3-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain dbus libusb systemd"
PKG_LONGDESC="SDL3 built with only input subsystems for RetroArch"
PKG_TOOLCHAIN="cmake"
PKG_BUILD_FLAGS="+pic"

PKG_CMAKE_OPTS_TARGET="-DSDL_STATIC=OFF \
                       -DSDL_SHARED=ON \
                       -DCMAKE_INSTALL_LIBDIR=lib \
                       -DSDL_AUDIO=OFF \
                       -DSDL_RENDER=OFF \
                       -DSDL_GPU=OFF \
                       -DSDL_CAMERA=OFF \
                       -DSDL_POWER=OFF \
                       -DSDL_DIALOG=OFF \
                       -DSDL_TRAY=OFF \
                       -DSDL_IBUS=OFF \
                       -DSDL_OFFSCREEN=OFF \
                       -DSDL_TEST_LIBRARY=OFF \
                       -DSDL_TESTS=OFF \
                       -DSDL_INSTALL_TESTS=OFF \
                       -DSDL_JOYSTICK=ON \
                       -DSDL_HAPTIC=ON \
                       -DSDL_SENSOR=ON \
                       -DSDL_VIRTUAL_JOYSTICK=OFF \
                       -DSDL_HIDAPI=ON \
                       -DSDL_HIDAPI_LIBUSB=ON \
                       -DSDL_HIDAPI_JOYSTICK=ON"

if [ "${DISPLAYSERVER}" = "x11" ]; then
  PKG_CMAKE_OPTS_TARGET+=" -DSDL_VIDEO=ON -DSDL_X11=ON -DSDL_X11_SHARED=ON \
                           -DSDL_OPENGL=OFF -DSDL_OPENGLES=OFF -DSDL_VULKAN=OFF"
  PKG_DEPENDS_TARGET+=" libX11 libXcursor libXext libXfixes libXi libXrandr libXrender"
else
  PKG_CMAKE_OPTS_TARGET+=" -DSDL_VIDEO=OFF"
fi

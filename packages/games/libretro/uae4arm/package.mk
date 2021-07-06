################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
#
#  This Program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  This Program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.tv; see the file COPYING.  If not, write to
#  the Free Software Foundation, 51 Franklin Street, Suite 500, Boston, MA 02110, USA.
#  http://www.gnu.org/copyleft/gpl.html
################################################################################

PKG_NAME="uae4arm"
PKG_VERSION="a1838fc526524c0a2c407a5773acbd54dd1a6a3b"
PKG_SHA256="7713dab5f833219fa0b37ee925841eb06aa30b66b093a9e1dd61c5c87390a2e8"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/uae4arm-libretro"
PKG_URL="$PKG_SITE/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="Port of uae4arm for libretro (rpi/android)"
PKG_LONGDESC="Port of uae4arm for libretro (rpi/android) "

PKG_IS_ADDON="no"
PKG_TOOLCHAIN="make"
PKG_AUTORECONF="no"
PKG_BUILD_FLAGS="-lto"
VERSION=${LIBREELEC_VERSION}

make_target() {
  if [ "${ARCH}" != "aarch64" ]; then
    CFLAGS="$CFLAGS -DARM -marm"
    if [[ "$TARGET_FPU" =~ "neon" ]]; then
      CFLAGS="-D__NEON_OPT"
    fi
    make HAVE_NEON=1 USE_PICASSO96=1
  fi
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  if [ "${ARCH}" != "aarch64" ]; then
    cp uae4arm_libretro.so $INSTALL/usr/lib/libretro/
  else
    cp -vP $PKG_BUILD/../../build.${DISTRO}-${DEVICE}.arm/uae4arm-*/.install_pkg/usr/lib/libretro/uae4arm_libretro.so $INSTALL/usr/lib/libretro/
  fi
}

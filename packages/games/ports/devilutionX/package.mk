# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present Shanti Gilbert (https://github.com/shantigilbert)

PKG_NAME="devilutionX"
PKG_VERSION="3e61cb82696345a0cf5cc80123940854f79e672d"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="unlicense"
PKG_SITE="https://github.com/diasurgical/devilutionX"
PKG_URL="$PKG_SITE.git"
PKG_DEPENDS_TARGET="toolchain SDL2 SDL2_mixer SDL2_ttf libsodium"
PKG_LONGDESC="Diablo build for modern operating systems "
GET_HANDLER_SUPPORT="git"
PKG_BUILD_FLAGS="-lto"

pre_patch() {
  find $(echo "${PKG_BUILD}" | cut -f1 -d\ ) -type f -exec dos2unix -q {} \;
}

pre_configure_target() {
PKG_CMAKE_OPTS_TARGET=" -DBINARY_RELEASE=1 -DCMAKE_BUILD_TYPE="Release" -DDEBUG=OFF -DPREFILL_PLAYER_NAME=ON"
sed -i "s|;-static-libstdc++>|;-lstdc++>|" $PKG_BUILD/CMakeLists.txt
}

makeinstall_target() {
mkdir -p $INSTALL/usr/local/bin
mkdir -p $INSTALL/usr/config/distribution/devilutionx
cp -rf $PKG_BUILD/.$TARGET_NAME/devilutionx $INSTALL/usr/local/bin
cp -rf $PKG_BUILD/Packaging/resources/CharisSILB.ttf $PKG_BUILD/.$TARGET_NAME/devilutionx $INSTALL/usr/config/distribution/devilutionx
}

# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2026-present ShigeakiAsai

PKG_NAME="lakka_mount_agent"
PKG_VERSION="1.0"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_DEPENDS_TARGET="toolchain dbus glib connman"
PKG_LONGDESC="Watches ConnMan's IPv4 address state via D-Bus and retries configured .mount units when IPv4 becomes available."

post_install() {
  enable_service lakka-mount-agent.service
}

# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2026-present ShigeakiAsai

.PHONY: all
all: lakka-mount-agent

PREFIX = /usr

PKG_CONFIG ?= pkg-config
CFLAGS += $(shell $(PKG_CONFIG) --cflags dbus-1 glib-2.0)
LDLIBS += $(shell $(PKG_CONFIG) --libs dbus-1 glib-2.0)

lakka-mount-agent: lakka-mount-agent.c
	$(CC) $(CFLAGS) -o $@ $< $(LDLIBS)

.PHONY: install
install: lakka-mount-agent
	install -d $(DESTDIR)$(PREFIX)/bin
	install $< $(DESTDIR)$(PREFIX)/bin

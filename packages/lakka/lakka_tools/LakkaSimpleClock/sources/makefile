# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

# Makefile for LakkaSimpleClock libretro core

TARGET_NAME := lakkasimpleclock_libretro

ifeq ($(platform),)
	platform = unix
endif

TARGET  := $(TARGET_NAME).so
fpic    := -fPIC
SHARED  := -shared -Wl,--no-undefined

REAL_LDFLAGS = $(LDFLAGS) -lm

ifneq ($(wildcard link.options),)
	SHARED += -Wl,--version-script=link.options
endif

REAL_CFLAGS = $(CFLAGS) $(fpic) -O2 -Wall -I.

OBJS := clock_core.o clock_render.o

.PHONY: all clean

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(fpic) $(SHARED) -o $@ $(OBJS) $(REAL_LDFLAGS)

%.o: %.c
	$(CC) $(REAL_CFLAGS) -c -o $@ $<

clean:
	rm -f $(OBJS) $(TARGET)

/*
 * LakkaSimpleClock - Standalone Universal Retro Gadget Core
 * Copyright (C) 2026 ASAI, Shigeaki <asai@cocoa.ocn.ne.jp>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://gnu.org>.
 */

#ifndef CLOCK_RENDER_H
#define CLOCK_RENDER_H

#include <stdint.h>
#include <time.h>
#include <stdbool.h>

#define PI 3.14159265358979323846
#define WIDTH 320
#define HEIGHT 240

#define COLOR_BLACK   0x0000
#define COLOR_WHITE   0xFFFF
#define COLOR_GRAY    0x7BEF
#define COLOR_RED     0xF800
#define COLOR_GREEN   0x07E0
#define COLOR_BLUE    0x001F
#define COLOR_YELLOW  0xFFE0

extern uint16_t video_buffer[WIDTH * HEIGHT];

void init_lakka_logo(void);
void draw_line(int x0, int y0, int x1, int y1, uint16_t color);
void draw_analog_clock(int cx, int cy, int r, const struct tm *current_time);
void draw_digital_clock(int y_start, const struct tm *current_time, bool is_edit_mode, int edit_cursor, int frame_count, bool is_network_online);

#endif /* CLOCK_RENDER_H */

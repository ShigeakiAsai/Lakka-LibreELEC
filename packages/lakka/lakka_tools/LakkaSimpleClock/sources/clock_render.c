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

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdbool.h>
#include "clock_render.h"
#include "font.h"

/* Automatically includes the build-time compiled 64x64 original color image table array */
#include "lakka_logo_res.h"

/* Synced with clock_core.c: Left-to-right universal visual sequence map */
#define CURSOR_DAY   0  /* Visual 1st */
#define CURSOR_MONTH 1  /* Visual 2nd */
#define CURSOR_YEAR  2  /* Visual 3rd */
#define CURSOR_HOUR  3  /* Visual 4th */
#define CURSOR_MIN   4  /* Visual 5th */
#define CURSOR_SEC   5  /* Visual 6th */

/* Restored the missing master English Month lookup dictionary array */
static const char *MONTH_NAMES[] = { "JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC" };

void init_lakka_logo(void) {}

/* Bresenham's line algorithm for analog clock hands */
void draw_line(int x0, int y0, int x1, int y1, uint16_t color) {
   int dx = abs(x1 - x0), sx = x0 < x1 ? 1 : -1;
   int dy = -abs(y1 - y0), sy = y0 < y1 ? 1 : -1;
   int err = dx + dy, e2;
   while (1) {
      draw_pixel_safe(x0, y0, color);
      if (x0 == x1 && y0 == y1) break;
      e2 = 2 * err;
      if (e2 >= dy) { err += dy; x0 += sx; }
      if (e2 <= dx) { err += dx; y0 += sy; }
   }
}

/* Render analog clock face and hands */
void draw_analog_clock(int cx, int cy, int r, const struct tm *current_time) {
   /* Clock dial markers (12, 3, 6, 9) */
   draw_pixel_safe(cx, cy - r, COLOR_WHITE);
   draw_pixel_safe(cx + r, cy, COLOR_WHITE);
   draw_pixel_safe(cx, cy + r, COLOR_WHITE);
   draw_pixel_safe(cx - r, cy, COLOR_WHITE);

   /* Angle calculations (Offset by -PI/2 to start at 12 o'clock) */
   float hour_angle = ((current_time->tm_hour % 12) * 30 + current_time->tm_min * 0.5) * PI / 180.0 - PI / 2.0;
   float min_angle = (current_time->tm_min * 6) * PI / 180.0 - PI / 2.0;
   float sec_angle = (current_time->tm_sec * 6) * PI / 180.0 - PI / 2.0;

   /* Draw Hour (Red), Minute (Green), Second (Blue) hands cleanly without logo interference */
   draw_line(cx, cy, cx + (int)(cos(hour_angle) * (r * 0.5)), cy + (int)(sin(hour_angle) * (r * 0.5)), COLOR_RED);
   draw_line(cx, cy, cx + (int)(cos(min_angle) * (r * 0.8)), cy + (int)(sin(min_angle) * (r * 0.8)), COLOR_GREEN);
   draw_line(cx, cy, cx + (int)(cos(sec_angle) * (r * 0.9)), cy + (int)(sin(sec_angle) * (r * 0.9)), COLOR_BLUE);
}

/* Render digital clock interface and status indicators with dynamic centering */
void draw_digital_clock(int y_start, const struct tm *current_time, bool is_edit_mode, int edit_cursor, int frame_count, bool is_network_online) {
   char year_part[16], month_part[16], day_part[16];
   char hour_part[16], min_part[16], sec_part[16];

   bool show_blink = ((frame_count / 30) % 2 == 0);

   /* Format individual Date parts */
   snprintf(year_part,  sizeof(year_part),  "%04d", current_time->tm_year + 1900);
   snprintf(day_part,   sizeof(day_part),   "%02d", current_time->tm_mday);
   snprintf(month_part, sizeof(month_part), "%s",   MONTH_NAMES[current_time->tm_mon]);

   /* Updated color matching logic to align with the new unified sequential index definitions */
   uint16_t c_day   = is_edit_mode ? (edit_cursor == CURSOR_DAY   ? COLOR_WHITE : COLOR_YELLOW) : COLOR_WHITE;
   uint16_t c_month = is_edit_mode ? (edit_cursor == CURSOR_MONTH ? COLOR_WHITE : COLOR_YELLOW) : COLOR_WHITE;
   uint16_t c_year  = is_edit_mode ? (edit_cursor == CURSOR_YEAR  ? COLOR_WHITE : COLOR_YELLOW) : COLOR_WHITE;

   /* Blinking blackout index sync matching the linear visual stream */
   if (is_edit_mode && !show_blink) {
      if (edit_cursor == CURSOR_DAY)   c_day   = COLOR_BLACK;
      if (edit_cursor == CURSOR_MONTH) c_month = COLOR_BLACK;
      if (edit_cursor == CURSOR_YEAR)  c_year  = COLOR_BLACK;
   }

   /* Fixed Layout Math: 11 chars * 4px per char = 44px base. Scaled x2 = Exactly 88px total width. */
   int date_x = (WIDTH / 2) - (88 / 2);
   
   /* 1. Day (2 characters) */
   draw_string_3x5(date_x, y_start, day_part, 2, c_day);
   date_x += 2 * 4 * 2; /* Move exactly 16px right */
   
   /* 2. Slash 1 (1 character) */
   draw_string_3x5(date_x, y_start, "/", 2, is_edit_mode ? COLOR_YELLOW : COLOR_WHITE);
   date_x += 1 * 4 * 2; /* Move exactly 8px right */
   
   /* 3. Month (3 characters - "JUN") */
   draw_string_3x5(date_x, y_start, month_part, 2, c_month);
   date_x += 3 * 4 * 2; /* Move exactly 24px right */
   
   /* 4. Slash 2 (1 character) */
   draw_string_3x5(date_x, y_start, "/", 2, is_edit_mode ? COLOR_YELLOW : COLOR_WHITE);
   date_x += 1 * 4 * 2; /* Move exactly 8px right */
   
   /* 5. Year (4 characters) */
   draw_string_3x5(date_x, y_start, year_part, 2, c_year);


   /* --- 2. Standard 24H Time Formatting (HH:MM:SS) --- */
   snprintf(hour_part, sizeof(hour_part), "%02d", current_time->tm_hour);
   snprintf(min_part,  sizeof(min_part),  "%02d", current_time->tm_min);
   snprintf(sec_part,  sizeof(sec_part),  "%02d", current_time->tm_sec);

   uint16_t c_hour = is_edit_mode ? (edit_cursor == CURSOR_HOUR ? COLOR_WHITE : COLOR_YELLOW) : COLOR_WHITE;
   uint16_t c_min  = is_edit_mode ? (edit_cursor == CURSOR_MIN  ? COLOR_WHITE : COLOR_YELLOW) : COLOR_WHITE;
   uint16_t c_sec  = is_edit_mode ? (edit_cursor == CURSOR_SEC  ? COLOR_WHITE : COLOR_YELLOW) : COLOR_WHITE;

   if (is_edit_mode && !show_blink) {
      if (edit_cursor == CURSOR_HOUR) c_hour = COLOR_BLACK;
      if (edit_cursor == CURSOR_MIN)  c_min  = COLOR_BLACK;
      if (edit_cursor == CURSOR_SEC)  c_sec  = COLOR_BLACK;
   }

   /* Dynamically render the Time parts separately (Scale: 3, total width: 96px) */
   int time_x = (WIDTH / 2) - (96 / 2);

   draw_string_3x5(time_x, y_start + 20, hour_part, 3, c_hour);
   time_x += 2 * 4 * 3;
   draw_string_3x5(time_x, y_start + 20, ":", 3, is_edit_mode ? COLOR_YELLOW : COLOR_WHITE);
   time_x += 1 * 4 * 3;

   draw_string_3x5(time_x, y_start + 20, min_part, 3, c_min);
   time_x += 2 * 4 * 3;
   draw_string_3x5(time_x, y_start + 20, ":", 3, is_edit_mode ? COLOR_YELLOW : COLOR_WHITE);
   time_x += 1 * 4 * 3;

   draw_string_3x5(time_x, y_start + 20, sec_part, 3, c_sec);


   /* --- 3. Navigation Guidelines Rendering (Top layout edges via 8x8 font) --- */
   if (!is_network_online) {
      draw_string_8x8(14, 10, "EDIT", 1, COLOR_WHITE);
      uint16_t start_color = is_edit_mode ? COLOR_YELLOW : COLOR_GRAY;
      draw_string_8x8(0, 20, "(START)", 1, start_color);
   }

   draw_string_8x8(261, 10, "EXIT", 1, COLOR_WHITE);
   draw_string_8x8(243, 22, "(SELECT)", 1, COLOR_GRAY);


   /* --- 4. Bottom Status Indicator bar --- */
   const char *status_str = "";
   uint16_t status_color = COLOR_WHITE;

   if (is_network_online) {
      status_str = "Network ONLINE";
      status_color = COLOR_GREEN;
   } else if (is_edit_mode) {
      status_str = "EDIT MODE";
      status_color = COLOR_YELLOW;
   } else {
      status_str = "Network OFFLINE";
      status_color = COLOR_WHITE;
   }

   int status_width = ((int)strlen(status_str) * 9 - 1) * 1;
   int status_x = (WIDTH / 2) - (status_width / 2);
   draw_string_8x8(status_x, y_start + 50, status_str, 1, status_color);


   /* --- 5. Master Layer Priority Logo overlay (64x64 at the bottom-right corner) --- */
   int logo_start_x = 251; /* 320 - 64 - 5 */
   int logo_start_y = 171; /* 240 - 64 - 5 */
   for (int row = 0; row < 64; row++) {
      for (int col = 0; col < 64; col++) {
         uint16_t pixel_color = lakka_logo_64x64[row * 64 + col];
         if (pixel_color != 0x0000) { /* Transparency check */
            draw_pixel_safe(logo_start_x + col, logo_start_y + row, pixel_color);
         }
      }
   }
}

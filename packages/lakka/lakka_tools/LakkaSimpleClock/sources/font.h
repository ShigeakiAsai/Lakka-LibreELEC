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

#ifndef FONT_H
#define FONT_H

#include <stdint.h>
#include <stdbool.h>

/* --- 3x5 Bitmap Font: Numbers and Essential Symbols --- */
static const uint16_t font_3x5[] = {
   0x7B6F,  /* '0' (Index 0) */
   0x2492,  /* '1' (Index 1) */
   0x73E7,  /* '2' (Index 2) */
   0x73CF,  /* '3' (Index 3) */
   0x5BC9,  /* '4' (Index 4) */
   0x79CF,  /* '5' (Index 5) */
   0x79EF,  /* '6' (Index 6) */
   0x7249,  /* '7' (Index 7) */
   0x7BEF,  /* '8' (Index 8) */
   0x7BCF,  /* '9' (Index 9) */
   0x0000,  /* ' ' (Space: Index 10) */
   0x0410,  /* ':' (Index 11) */
   0x1294,  /* '/' (Index 12) */
   0x2D29,  /* '(' (Index 13) */
   0x4924,  /* ')' (Index 14) */
   0x01C0   /* '-' (Index 15) */
};

/* --- 3x5 Bitmap Font: Capital Alphabets 'A'-'Z' --- */
static const uint16_t font_3x5_alphabets[] = {
   0x2BED,  /* 'A' (Index 0) */
   0x6BAE,  /* 'B' (Index 1) */
   0x7927,  /* 'C' (Index 2) */
   0x6B6E,  /* 'D' (Index 3) */
   0x79A7,  /* 'E' (Index 4) */
   0x79A4,  /* 'F' (Index 5) */
   0x796F,  /* 'G' (Index 6) */
   0x5BED,  /* 'H' (Index 7) */
   0x7497,  /* 'I' (Index 8) */
   0x126F,  /* 'J' (Index 9) */
   0x5DAD,  /* 'K' (Index 10) */
   0x4927,  /* 'L' (Index 11) */
   0x5FED,  /* 'M' (Index 12) */
   0x5F6D,  /* 'N' (Index 13) */
   0x7B6F,  /* 'O' (Index 14) */
   0x7BE4,  /* 'P' (Index 15) */
   0x7B79,  /* 'Q' (Index 16) */
   0x7BED,  /* 'R' (Index 17) */
   0x79CF,  /* 'S' (Index 18) */
   0x7492,  /* 'T' (Index 19) */
   0x5B6F,  /* 'U' (Index 20) */
   0x5B52,  /* 'V' (Index 21) */
   0x5BFD,  /* 'W' (Index 22) */
   0x5AAD,  /* 'X' (Index 23) */
   0x5A92,  /* 'Y' (Index 24) */
   0x72A7   /* 'Z' (Index 25) */
};

/* --- 8x8 Bitmap Font: High-Res Alphabets --- */
static const uint64_t font_8x8[] = {
   0x183C667E66666600ULL, 0x7C66667C66667C00ULL, 0x3C66C0C0C0663C00ULL,
   0x786C6666666C7800ULL, 0x7E60607C60607E00ULL, 0x7E60607C60606000ULL,
   0x3C66C0CC66663E00ULL, 0x6666667E66666600ULL, 0x3E0C0C0C0C0C3E00ULL,
   0x1E0C0C0C0C4C3800ULL, 0x666C7870786C6600ULL, 0x6060606060607E00ULL,
   0x63777BE343434300ULL, 0x66763E5E6E666600ULL, 0x3C66666666663C00ULL,
   0x7C66667C60606000ULL, 0x3C666666666C3A06ULL, 0x7C66667C786C6600ULL,
   0x3C6630180C663C00ULL, 0x7E18181818181800ULL, 0x6666666666663C00ULL,
   0x66666666663C1800ULL, 0x434343E37B776300ULL, 0x66663C183C666600ULL,
   0x6666663C18181800ULL, 0x7E060C1830607E00ULL, 0x0C18303030180C00ULL,
   0x30180C0C0C183000ULL,
   /* Lowercase alphabets 'a'-'z' */
   0x00003C063E663B00ULL, 0x60607C6666667C00ULL, 0x00003C6260623C00ULL,
   0x06063E6666663E00ULL, 0x00003C667E603C00ULL, 0x1C24782424242400ULL,
   0x00003B66663E063CULL, 0x60607C6666666600ULL, 0x0C000C0C0C0C0C00ULL,
   0x0C000C0C0C0C4C38ULL, 0x6064687068646600ULL, 0x3030303030301C00ULL,
   0x00006E7B73636300ULL, 0x00007C6666666600ULL, 0x00003C6666663C00ULL,
   0x00007C66667C6060ULL, 0x00003E66663E0606ULL, 0x00007C6660606000ULL,
   0x00003E603C065C00ULL, 0x18187C1818181C00ULL, 0x0000666666663B00ULL,
   0x00006666663C1800ULL, 0x0000636B7F362200ULL, 0x0000663C183C6600ULL,
   0x00006666663E063CULL, 0x00007E0C18307E00ULL
};

#define WIDTH 320
#define HEIGHT 240
extern uint16_t video_buffer[WIDTH * HEIGHT];

/* Safe pixel drawing boundary check */
static inline void draw_pixel_safe(int x, int y, uint16_t color) {
   if (x >= 0 && x < WIDTH && y >= 0 && y < HEIGHT) {
      video_buffer[y * WIDTH + x] = color;
   }
}

/* Master 3x5 Renderer: Dynamically branches into the correct bitmap array */
static inline void draw_char_3x5(int x, int y, int index, int scale, uint16_t color) {
   if (index < 0 || index > 41) return;

   uint16_t bitmap = 0;
   if (index <= 15) {
      bitmap = font_3x5[index];
   } else {
      bitmap = font_3x5_alphabets[index - 16];
   }

   for (int row = 0; row < 5; row++) {
      for (int col = 0; col < 3; col++) {
         int bit_pos = 14 - (row * 3 + col);
         if ((bitmap >> bit_pos) & 1) {
            for (int sy = 0; sy < scale; sy++) {
               for (int sx = 0; sx < scale; sx++) {
                  draw_pixel_safe(x + (col * scale) + sx, y + (row * scale) + sy, color);
               }
            }
         }
      }
   }
}

/* Placed draw_char_8x8 BEFORE draw_string_8x8 to clear implicit function warning */
static inline void draw_char_8x8(int x, int y, int index, int scale, uint16_t color) {
   if (index < 0 || index > 53) return;
   uint64_t bitmap = font_8x8[index];
   for (int row = 0; row < 8; row++) {
      for (int col = 0; col < 8; col++) {
         int bit_pos = 63 - (row * 8 + col);
         if ((bitmap >> bit_pos) & 1) {
            for (int sy = 0; sy < scale; sy++) {
               for (int sx = 0; sx < scale; sx++) {
                  draw_pixel_safe(x + (col * scale) + sx, y + (row * scale) + sy, color);
               }
            }
         }
      }
   }
}

/* Master 3x5 String Compiler (Left-to-Right layout stream) */
static inline void draw_string_3x5(int x, int y, const char *str, int scale, uint16_t color) {
   int current_x = x;
   while (*str) {
      int index = 10; /* Default to space */
      if (*str >= '0' && *str <= '9') index = *str - '0';
      else if (*str == ':') index = 11;
      else if (*str == '/') index = 12;
      else if (*str == '(') index = 13;
      else if (*str == ')') index = 14;
      else if (*str == '-') index = 15;
      else if (*str >= 'A' && *str <= 'Z') index = 16 + (*str - 'A');
      
      draw_char_3x5(current_x, y, index, scale, color);
      current_x += (3 + 1) * scale; /* 3px width + 1px spacing trailing gap */
      str++;
   }
}

/* Master 8x8 String Compiler (Left-to-Right layout stream) */
static inline void draw_string_8x8(int x, int y, const char *str, int scale, uint16_t color) {
   int current_x = x;
   while (*str) {
      int index = 0;
      if (*str >= 'A' && *str <= 'Z')      index = *str - 'A';
      else if (*str == '(') index = 26;
      else if (*str == ')') index = 27;
      else if (*str >= 'a' && *str <= 'z') index = 28 + (*str - 'a');
      else if (*str == ' ') {
         current_x += (8 + 1) * scale;
         str++;
         continue;
      }
      draw_char_8x8(current_x, y, index, scale, color);
      current_x += (8 + 1) * scale;
      str++;
   }
}

#endif /* FONT_H */

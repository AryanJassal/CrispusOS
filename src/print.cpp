#pragma once

#include "io.cpp"
#include "typedefs.cpp"

#define VGA_MEMORY (uint_8*) 0xb80000
#define VGA_WIDTH 80

uint_16 cursor_position;

void set_cursor_position(uint_16 position)
{
    outb(0x3d4, 0x0f);
    outb(0x3d5, (uint_8)(position & 0xff));
    outb(0x3d4, 0x0e);
    outb(0x3d5, (uint_8)((position >> 8) & 0xff));

    cursor_position = position;
}

uint_16 position_from_coordinates(uint_16 x, uint_16 y)
{
    return y * VGA_WIDTH + x;
}

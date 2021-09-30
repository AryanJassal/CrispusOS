#pragma once

#include "io.cpp"
#include "typedefs.cpp"

#define VGA_MEMORY (uint_8*) 0xb8000
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

void print(const char* str)
{
    uint_8* char_ptr = (uint_8*)str;        // Duplicate the input to change it without altering the input argument
    uint_16 cursor_index = cursor_position;
    while(*char_ptr != 0)                   // Remember, the end of a string has a null byte (0 num)
    {
        switch (*char_ptr)
        {
            case 10:
                cursor_index += VGA_WIDTH;
                break;

            case 13:
                cursor_index -= cursor_index % VGA_WIDTH;
                break;

            default:
                *(VGA_MEMORY + cursor_index * 2) = *char_ptr;
                // VGA Memory offset by index (next character) times 2 (each character takes 2 memory spaces for char and formatting)
                cursor_index++;
        }
        
        char_ptr++;
    }
    set_cursor_position(cursor_index);
}

char hex_to_string_out[128];

template<typename T>
const char* hex_to_string(T value)
{
    T* val_ptr = &value;
    uint_8* ptr;
    uint_8 temp;
    uint_8 size = (sizeof(T)) * 2 - 1;

    for (uint_8 i = 0; i < size; i++)
    {
        ptr = ((uint_8*)val_ptr + i);
        // The current letter is the value (val_ptr) plus the character we are on... i think...

        // -----------------------------------------------------
        temp = ((*ptr & 0xf0) >> 4);
        hex_to_string_out[size - (i * 2 + 1)] = temp + (temp > 9 ? 55 : 48);
        temp = (*ptr & 0x0f);
        hex_to_string_out[size - (i * 2)] = temp + (temp > 9 ? 55 : 48);
        // -----------------------------------------------------
        // Vodoo crap section ends
        // Like I don't even know how it works the theory nothing! Please explain before or after you write some complex piece of code or logic
    }
    hex_to_string_out[size + 1] = 0;

    return hex_to_string_out;
}

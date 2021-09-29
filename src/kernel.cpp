#include "print.cpp"

extern "C" void _start()
{
    set_cursor_position(position_from_coordinates(0, 0));

    return;
}
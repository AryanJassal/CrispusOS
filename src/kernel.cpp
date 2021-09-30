#include "print.cpp"

extern "C" void _start()
{
    set_cursor_position(position_from_coordinates(0, 0));
    print("Hello, world!\n\rHello, CPU!\n\r");
    print(hex_to_string(0x1234abcd));
    print("\n\r");
    print(hex_to_string("Hi!"));

    return;
}
#pragma once

// Output a particular value (val) on a particular bit (port)
void outb(unsigned short port, unsigned char val)
{
    asm volatile ("outb %0, %1" : : "a"(val), "Nd"(port));
    // Like bruh, wtf?? Wth even is inline assembly?
    // As far as I know, the above line works on some black vodoo magic or something i dont know
}

// Reads a value from a particular bit (port)
unsigned char inb(unsigned short port)
{
    unsigned char val;
    asm volatile ("inb %1, %0"
    : "=a"(val)
    : "Nd"(port));
    // Same vodoo crap here as well

    return val;
}

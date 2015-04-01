#ifndef TTY_H
#define TTY_H

#include "vga.h"
#include <stddef.h>
#include <stdint.h>

size_t terminal_row;
size_t terminal_column;
uint8_t terminal_color;

void terminal_initialize();
void terminal_newline();
void terminal_putc(char c);
void terminal_print(const char* str);

#endif // TTY_H


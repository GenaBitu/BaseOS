#include<stdio.h>
extern void terminal_putc(char c);
extern void terminal_print(const char* str);

int puts(const char* str)
{
	terminal_print(str);
	terminal_putc('\n');
}


#include<stdio.h>
extern void terminal_putc(char c);

int putchar(int character)
{
	char ch = (char) character;
	terminal_putc(ch);
	return character;
}


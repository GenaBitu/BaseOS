#include "../../../include/tty.h"

size_t strlen(const char* str)
{
	size_t len = 0;
	while(str[len] != 0)
	{
		len++;
	}
	return len;
}

void terminal_initialize()
{
	terminal_row = 0;
	terminal_column = 0;
	terminal_color = combine_vga_color(VGA_COLOR_BLACK, VGA_COLOR_GREEN);
	for(size_t y = 0; y < VGA_HEIGHT; y++)
	{
		for(size_t x = 0; x < VGA_WIDTH; x++)
		{
			VGA_MEMORY[y * VGA_WIDTH + x] = make_vga_char(' ', terminal_color);
		}
	}
}

void terminal_newline()
{
	terminal_column = 0;
	if (++terminal_row == VGA_HEIGHT)
	{
		terminal_row = 0;
	}
}
 
void terminal_putc(char c)
{
	if(c == '\n')
	{
		terminal_newline();
		return;
	}
	VGA_MEMORY[terminal_row * VGA_WIDTH + terminal_column] = make_vga_char(c, terminal_color);
	if (++terminal_column == VGA_WIDTH)
	{
		terminal_newline();
	}
}

void terminal_print(const char* str)
{
	size_t len = strlen(str);
	for (size_t i = 0; i < len; i++)
	{
		terminal_putc(str[i]);
	}
}


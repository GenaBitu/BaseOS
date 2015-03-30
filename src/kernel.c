#include "../include/kernel.h"
size_t terminal_row;
size_t terminal_column;
uint8_t terminal_color;

size_t strlen(const char* str)
{
	size_t ret = 0;
	while(str[ret] != 0)
	{
		ret++;
	}
	return ret;
}
 
void terminal_initialize()
{
	terminal_row = 0;
	terminal_column = 0;
	terminal_color = make_color(COLOR_LIGHT_GREY, COLOR_BLACK);
	for(size_t y = 0; y < VGA_HEIGHT; y++)
	{
		for(size_t x = 0; x < VGA_WIDTH; x++)
		{
			VGA_MEMORY[y * VGA_WIDTH + x] = make_vgaentry(' ', terminal_color);
		}
	}
}
 
void terminal_put(char c)
{
	if(c == '\n')
	{
		if (++terminal_row == VGA_HEIGHT)
		{
			terminal_row = 0;
		}
		terminal_column = 0;
		return;
	}
	VGA_MEMORY[terminal_row * VGA_WIDTH + terminal_column] = make_vgaentry(c, terminal_color);
	if (++terminal_column == VGA_WIDTH)
	{
		terminal_column = 0;
		if (++terminal_row == VGA_HEIGHT)
		{
			terminal_row = 0;
		}
	}
}

void terminal_print(const char* data)
{
	size_t datalen = strlen(data);
	for (size_t i = 0; i < datalen; i++)
	{
		terminal_put(data[i]);
	}
}
 
#if defined(__cplusplus)
extern "C"
#endif
void kernel_early()
{
	terminal_initialize();
}
void kernel_main()
{
	terminal_print("Hello World!\nWelcome to multiline!");
}

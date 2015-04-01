#include "../include/kernel.h"
 
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

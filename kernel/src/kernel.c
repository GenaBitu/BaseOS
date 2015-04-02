#include "../include/kernel.h"
 
#ifdef __cplusplus
extern "C"
#endif // __cplusplus
void kernel_early()
{
	terminal_initialize();
}
void kernel_main()
{
	terminal_print("Hello World!\nWelcome to multiline!");
}


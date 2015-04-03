#include<string.h>

void* memchr(const void* ptr, int value, size_t num)
{
	const char* ch = (const char*) ptr;
	for(size_t i = 0; i < num; i++)
	{
		if(ch[i] == value)
		{
			return (void*) ch[i];
		}
	}
	return NULL;
}


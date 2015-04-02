#include<string.h>

void* memmove(void* destination, const void* source, size_t num)
{
	unsigned char* dest = (unsigned char*) destination;
	const unsigned char* src = (const unsigned char*) source;
	if(dest < src)
	{
		for(size_t i = 0; i < num; i++)
		{
			dest[i] = src[i];
		}
	}
	else
	{
		for(size_t i = num; i != 0; i--)
		{
			dest[i-1] = src[i-1];
		}
	}
	return destination;
}


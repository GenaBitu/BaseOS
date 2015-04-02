#include<string.h>

void* memcpy(void* __restrict destination, const void* __restrict source, size_t num)
{
	unsigned char* dest = (unsigned char*) destination;
	const unsigned char* src = (const unsigned char*) source;
	for(size_t i = 0; i < num; i++)
	{
		dest[i] = src[i];
	}
	return destination;
}


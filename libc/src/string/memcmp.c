#include<string.h>

int memcmp(const void* ptr1, const void* ptr2, size_t num)
{
	const unsigned char* ch1 = (const unsigned char*) ptr1;
	const unsigned char* ch2 = (const unsigned char*) ptr2;
	for(size_t i = 0; i < num; i++)
	{
		if(ch1[i] != ch2[i])
		{
			return ch1[i] - ch2[i];
		}
	}
	return 0;
}


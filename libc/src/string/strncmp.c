#include<string.h>

int strncmp(const char* ptr1, const char* ptr2, size_t num)
{
	for(size_t i = 0; i < num; i++)
	{
		if(ptr1[i] != ptr2[i])
		{
			return ptr1[i] - ptr2[i];
		}
		else if(ptr1[i] == '\0')
		{
			return 0;
		}
	}
	return 0;
}


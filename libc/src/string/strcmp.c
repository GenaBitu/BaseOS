#include<string.h>

int strcmp(const char* ptr1, const char* ptr2)
{
	size_t i = 0;
	while(ptr1[i] != '\0' && ptr2[i] != '\0')
	{
		if(ptr1[i] != ptr2[i])
		{
			return ptr1[i] - ptr2[i];
		}
	}
	return 0;
}


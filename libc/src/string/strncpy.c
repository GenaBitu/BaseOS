#include<string.h>

char* strncpy(char* destination, const char* source, size_t num)
{
	
	int flag = 0;
	for(size_t i = 0; i < num; i++)
	{
		if(source[i] == '\0')
		{
			flag = 1;
		}
		destination[i] = flag == 0 ? source[i] : '\0';
	}
	return destination;
}


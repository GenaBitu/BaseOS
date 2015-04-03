#include<string.h>

char* strncat(char* destination, const char* source, size_t num)
{
	size_t len = strlen(destination);
	int flag = 0;
	for(size_t i = 0; i < num; i++)
	{
		if(source[i] == '\0')
		{
			flag = 1;
		}
		destination[len + i] = flag == 0 ? source[i] : '\0';
	}
	return destination;
}


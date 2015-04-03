#include<string.h>

char* strcpy(char* destination, const char* source)
{
	size_t i = 0;
	while(source[i] != '\0')
	{
		destination[i] = source[i];
		i++;
	}
	destination[i] = '\0';
	return destination;
}


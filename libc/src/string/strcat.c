#include<string.h>

char* strcat(char* destination, const char* source)
{
	size_t len = strlen(destination);
	size_t i = 0;
	while (source[i] != '\0')
	{
		destination[len + i] = source[i];
	}
	return destination;
}


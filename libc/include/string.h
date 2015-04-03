#ifndef STRING_H
#define STRING_H

#include<stddef.h>
#include<sys/cdefs.h>
#include<features.h>

BEGIN_CPP_DECLS

void* memcpy(void* __restrict destination, const void* __restrict source, size_t num);
void* memmove(void* destination, const void* source, size_t num);
char* strcpy(char* destination, const char* source);
char* strncpy(char* destination, const char* source, size_t num);
char* strcat(char* destination, const char* source);
char* strncat(char* destination, const char* source, size_t num);
int memcmp(const void* ptr1, const void* ptr2, size_t num);
int strcmp(const char* ptr1, const char* ptr2);
int strncmp(const char* ptr1, const char* ptr2, size_t num);
void* memchr(const void* ptr, int value, size_t num);
void* memset(void* ptr, int value, size_t num);
size_t strlen(const char* str);

END_CPP_DECLS

#endif // STRING_H


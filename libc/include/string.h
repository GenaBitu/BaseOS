#ifndef STRING_H
#define STRING_H

#include<stddef.h>
#include<sys/cdefs.h>
#include<features.h>

BEGIN_CPP_DECLS

int memcmp(const void* ptr1, const void* ptr2, size_t num);
void* memcpy(void* __restrict destination, const void* __restrict source, size_t num);
void* memmove(void* destination, const void* source, size_t num);
void* memset(void* ptr, int value, size_t num);
size_t strlen(const char* str);

END_CPP_DECLS

#endif // STRING_H


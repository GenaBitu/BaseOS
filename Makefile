AS = GCC-i686-elf/bin/i686-elf-as
AR = GCC-i686-elf/bin/i686-elf-ar
LD = GCC-i686-elf/bin/i686-elf-gcc
CC = GCC-i686-elf/bin/i686-elf-gcc

export SYSROOT = $(shell pwd)/sysroot
SYS_INCDIR = $(SYSROOT)/usr/include
SYS_LIBDIR = $(SYSROOT)/usr/lib

LDSCRIPT = linker.ld

ASFLAGS =
ARFLAGS = rcs
LDFLAGS = -ffreestanding -O2 --sysroot=$(SYSROOT) -isystem=/usr/include
LDLIBS = -lgcc
CFLAGS = --sysroot=$(SYSROOT) -isystem=/usr/include -std=c11 -ffreestanding -fbuiltin -O2 -Wall -Wextra 
LIBS = -nostdlib -lc -lgcc
SRCDIR = src
OBJDIR = obj
BINDIR = bin
ISODIR = iso

DIR_KERNEL = kernel
SRCDIR_KERNEL = $(DIR_KERNEL)/$(SRCDIR)
OBJDIR_KERNEL = $(DIR_KERNEL)/$(OBJDIR)
BINDIR_KERNEL = $(DIR_KERNEL)/$(BINDIR)

DIR_LIBC = libc
SRCDIR_LIBC = $(DIR_LIBC)/$(SRCDIR)
OBJDIR_LIBC = $(DIR_LIBC)/$(OBJDIR)
BINDIR_LIBC = $(DIR_LIBC)/$(BINDIR)
INCDIR_LIBC = $(DIR_LIBC)/include

ASFLAGS_I686 = $(ASFLAGS)
ARFLAGS_I686 = $(ARFLAGS)
LDFLAGS_I686 = $(LDFLAGS)
LDLIBS_I686 = $(LDLIBS)
CFLAGS_I686 = $(CFLAGS)
ISODIR_I686 = $(ISODIR)/i686

ARCHDIR_KERNEL_I686 = $(SRCDIR_KERNEL)/arch/i686
OBJDIR_KERNEL_I686 = $(OBJDIR_KERNEL)/i686
BINDIR_KERNEL_I686 = $(BINDIR_KERNEL)/i686
OUT_KERNEL_I686 = $(BINDIR_KERNEL_I686)/BaseOS.bin
CRTI_I686 = $(OBJDIR_KERNEL_I686)/crti.o
CRTN_I686 = $(OBJDIR_KERNEL_I686)/crtn.o

ARCHDIR_LIBC_I686 = $(SRCDIR_LIBC)/arch/i686
OBJDIR_LIBC_I686 = $(OBJDIR_LIBC)/i686
BINDIR_LIBC_I686 = $(BINDIR_LIBC)/i686
OUT_LIBC_I686 = $(BINDIR_LIBC_I686)/libc.a

CRTBEGIN = $(shell $(CC) $(CFLAGS) -print-file-name=crtbegin.o)
CRTEND = $(shell $(CC) $(CFLAGS) -print-file-name=crtend.o)

OBJLIST_KERNEL_I686 = $(OBJDIR_KERNEL_I686)/boot.o $(OBJDIR_KERNEL_I686)/tty.o $(OBJDIR_KERNEL_I686)/kernel.o
OBJ_KERNEL_I686 = $(CRTI_I686) $(CRTBEGIN) $(OBJLIST_KERNEL_I686) $(CRTEND) $(CRTN_I686)

OBJ_LIBC_STRING_I686 = $(OBJDIR_LIBC_I686)/string/memcmp.o $(OBJDIR_LIBC_I686)/string/memcpy.o $(OBJDIR_LIBC_I686)/string/memmove.o $(OBJDIR_LIBC_I686)/string/memset.o $(OBJDIR_LIBC_I686)/string/strlen.o
OBJ_LIBC_I686 = $(OBJ_LIBC_STRING_I686)

all: i686

clean: clean_i686
	rm -rf $(SYSROOT)

i686: libc_i686 kernel_i686

clean_i686: clean_kernel_i686 clean_libc_i686

kernel_i686: before_kernel_i686 out_kernel_i686

before_kernel_i686:
	mkdir -p $(BINDIR_KERNEL_I686)
	mkdir -p $(OBJDIR_KERNEL_I686)

out_kernel_i686: $(OBJ_KERNEL_I686) $(LDSCRIPT)
	$(LD) -T $(LDSCRIPT) -o $(OUT_KERNEL_I686) $(LDFLAGS_I686) $(OBJ_KERNEL_I686) $(LDFLAGS_I686) $(LIBS)

$(OBJDIR_KERNEL_I686)/%.o: $(ARCHDIR_KERNEL_I686)/%.asm
	$(AS) $(ASFLAGS_I686) $< -o $@

$(OBJDIR_KERNEL_I686)/%.o: $(ARCHDIR_KERNEL_I686)/%.c
	$(CC) -c $< -o $@ $(CFLAGS_I686)

$(OBJDIR_KERNEL_I686)/%.o: $(SRCDIR_KERNEL)/%.c
	$(CC) -c $< -o $@ $(CFLAGS_I686)

clean_kernel_i686:
	rm -rf $(OBJDIR_KERNEL_I686) $(BINDIR_KERNEL_I686) $(ISODIR_I686)

libc_i686: before_libc_i686 install-headers_libc_i686 out_libc_i686 install-libs_libc_i686

before_libc_i686:
	mkdir -p $(OBJDIR_LIBC_I686) $(OBJDIR_LIBC_I686)/string
	mkdir -p $(BINDIR_LIBC_I686)

out_libc_i686: $(OBJ_LIBC_I686)
	$(AR) $(ARFLAGS_I686) $(OUT_LIBC_I686) $(OBJ_LIBC_I686)

$(OBJDIR_LIBC_I686)/%.o: $(SRCDIR_LIBC)/%.c
	$(CC) -c $< -o $@ $(CFLAGS_I686)

install-headers_libc_i686: install-headers_libc

install-libs_libc_i686:
	mkdir -p $(SYS_LIBDIR)
	cp -RTv $(BINDIR_LIBC_I686) $(SYS_LIBDIR)

clean_libc_i686:
	rm -rf $(OBJDIR_LIBC_I686)
	rm -rf $(BINDIR_LIBC_I686)

install-headers_libc:
	mkdir -p $(SYS_INCDIR)
	cp -RTv $(INCDIR_LIBC) $(SYS_INCDIR)

.PHONY: all clean i686 clean_i686 kernel_i686 before_kernel_i686 out_kernel_i686 clean_kernel_i686 libc_i686 before_libc_i686 install_libc_i686 install-headers_libc_i686 install-libs_libc_i686 clean_libc_i686 install-headers_libc

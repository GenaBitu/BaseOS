AS = GCC-i686-elf/bin/i686-elf-as
LD = GCC-i686-elf/bin/i686-elf-gcc
CC = GCC-i686-elf/bin/i686-elf-gcc

LDSCRIPT = linker.ld

ASFLAGS =
LDFLAGS = -ffreestanding -O2 -nostdlib
LDLIBS = -lgcc
CFLAGS = -std=gnu99 -ffreestanding -O2 -Wall -Wextra
SRCDIR = src
OBJDIR = obj
BINDIR = bin
ISODIR = iso

DIR_KERNEL = kernel
OBJDIR_KERNEL = $(DIR_KERNEL)/$(OBJDIR)
BINDIR_KERNEL = $(DIR_KERNEL)/$(BINDIR)
ISODIR_KERNEL = $(DIR_KERNEL)/$(ISODIR)

DIR_LIBC = libc
OBJDIR_LIBC = $(DIR_LIBC)/$(OBJDIR)
BINDIR_LIBC = $(DIR_LIBC)/$(BINDIR)

ASFLAGS_I686 = $(ASFLAGS)
LDFLAGS_I686 = $(LDFLAGS)
LDLIBS_I686 = $(LDLIBS)
CFLAGS_I686 = $(CFLAGS)

SRCDIR_KERNEL_I686 = $(DIR_KERNEL)/$(SRCDIR)
ARCHDIR_KERNEL_I686 = $(SRCDIR_KERNEL_I686)/arch/i686
OBJDIR_KERNEL_I686 = $(OBJDIR_KERNEL)/i686
BINDIR_KERNEL_I686 = $(BINDIR_KERNEL)/i686
ISODIR_KERNEL_I686 = $(ISODIR_KERNEL)/i686
OUT_KERNEL_I686 = $(BINDIR_I686)/BaseOS.bin
CRTI_I686 = $(OBJDIR_I686)/crti.o
CRTN_I686 = $(OBJDIR_I686)/crtn.o

SRCDIR_LIBC_I686 = $(DIR_LIBC)/$(SRCDIR)
ARCHDIR_LIBC_I686 = $(SRCDIR_LIBC_I686)/arch/i686
OBJDIR_LIBC_I686 = $(OBJDIR_LIBC)/i686
BINDIR_LIBC_I686 = $(BINDIR_LIBC)/i686

CRTBEGIN = $(shell $(CC) $(CFLAGS) -print-file-name=crtbegin.o)
CRTEND = $(shell $(CC) $(CFLAGS) -print-file-name=crtend.o)

OBJLIST_KERNEL_I686 = $(OBJDIR_KERNEL_I686)/boot.o $(OBJDIR_KERNEL_I686)/kernel.o $(OBJDIR_KERNEL_I686)/tty.o
OBJ_KERNEL_I686 = $(CRTI_I686) $(CRTBEGIN) $(OBJLIST_KERNEL_I686) $(CRTEND) $(CRTN_I686)

OBJ_LIBC_I686 =

all: i686

clean: clean_i686

i686: kernel_i686 libc_i686

clean_i686: clean_kernel_i686 clean_libc_i686

kernel_i686: before_kernel_i686 out_kernel_i686

before_kernel_i686:
	mkdir -p $(BINDIR_KERNEL_I686)
	mkdir -p $(OBJDIR_KERNEL_I686)

out_kernel_i686: $(OBJ_KERNEL_I686) $(LDSCRIPT)
	$(LD) -T $(LDSCRIPT) -o $(OUT_KERNEL_I686) $(LDFLAGS_I686) $(OBJ_KERNEL_I686) $(LDFLAGS_I686)

$(OBJDIR_KERNEL_I686)/boot.o: $(ARCHDIR_KERNEL_I686)/boot.asm
	$(AS) $(ASFLAGS_I686) $(ARCHDIR_KERNEL_I686)/boot.asm -o $(OBJDIR_KERNEL_I686)/boot.o

$(OBJDIR_KERNEL_I686)/crti.o: $(ARCHDIR_KERNEL_I686)/crti.asm
	$(AS) $(ASFLAGS_I686) $(ARCHDIR_KERNEL_I686)/crti.asm -o $(OBJDIR_KERNEL_I686)/crti.o

$(OBJDIR_KERNEL_I686)/crtn.o: $(ARCHDIR_KERNEL_I686)/crtn.asm
	$(AS) $(ASFLAGS_I686) $(ARCHDIR_KERNEL_I686)/crtn.asm -o $(OBJDIR_KERNEL_I686)/crtn.o

$(OBJDIR_KERNEL_I686)/kernel.o: $(SRCDIR_KERNEL_I686)/kernel.c
	$(CC) -c $(SRCDIR_KERNEL_I686)/kernel.c -o $(OBJDIR_KERNEL_I686)/kernel.o $(CFLAGS_I686)

$(OBJDIR_KERNEL_I686)/tty.o: $(ARCHDIR_KERNEL_I686)/tty.c
	$(CC) -c $(ARCHDIR_KERNEL_I686)/tty.c -o $(OBJDIR_KERNEL_I686)/tty.o $(CFLAGS_I686)

clean_kernel_i686:
	rm -rf $(OBJDIR_KERNEL_I686) $(BINDIR_KERNEL_I686) $(ISODIR_KERNEL_I686)

libc_i686: before_libc_i686 $(OBJ_LIBC_I686) install_libc_i686

before_libc_i686:
	mkdir -p $(BINDIR_LIBC_I686)
	mkdir -p $(OBJDIR_LIBC_I686)

install_libc_i686: install-headers_libc_i686 install-libs_libc_i686

install-headers_libc_i686:

install-libs_libc_i686:

clean_libc_i686:
	rm -rf $(OBJDIR_LIBC_I686) $(BINDIR_LIBC_I686)

.PHONY: all clean i686 clean_i686 kernel_i686 before_kernel_i686 out_kernel_i686 clean_kernel_i686 libc_i686 before_libc_i686 install_libc_i686 install-headers_libc_i686 install-libs_libc_i686 clean_libc_i686

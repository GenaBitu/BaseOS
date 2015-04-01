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

ASFLAGS_I686 = $(ASFLAGS)
LDFLAGS_I686 = $(LDFLAGS)
LDLIBS_I686 = $(LDLIBS)
CFLAGS_I686 = $(CFLAGS)
SRCDIR_I686 = $(SRCDIR)
OBJDIR_I686 = $(OBJDIR)/i686
BINDIR_I686 = $(BINDIR)/i686
ISODIR_I686 = $(ISODIR)/i686
OUT_I686 = $(BINDIR_I686)/BaseOS.bin

OBJ_I686 = $(OBJDIR_I686)/boot.o $(OBJDIR_I686)/kernel.o $(OBJDIR_I686)/tty.o

all: i686

clean: clean_i686

i686: before_i686 out_i686

before_i686:
	test -d $(BINDIR_I686) || mkdir -p $(BINDIR_I686)
	test -d $(OBJDIR_I686) || mkdir -p $(OBJDIR_I686)

out_i686: $(OBJ_I686)
	$(LD) -T $(LDSCRIPT) -o $(OUT_I686) $(LDFLAGS_I686) $(OBJ_I686) $(LDFLAGS_I686)

$(OBJDIR_I686)/boot.o: $(SRCDIR_I686)/arch/i686/boot.asm
	$(AS) $(ASFLAGS_I686) $(SRCDIR_I686)/arch/i686/boot.asm -o $(OBJDIR_I686)/boot.o

$(OBJDIR_I686)/kernel.o: $(SRCDIR_I686)/kernel.c
	$(CC) -c $(SRCDIR_I686)/kernel.c -o $(OBJDIR_I686)/kernel.o $(CFLAGS_I686)

$(OBJDIR_I686)/tty.o: $(SRCDIR_I686)/arch/i686/tty.c
	$(CC) -c $(SRCDIR_I686)/arch/i686/tty.c -o $(OBJDIR_I686)/tty.o $(CFLAGS_I686)

clean_i686:
	rm -rf $(OBJDIR_I686) $(BINDIR_I686) $(ISODIR_I686)

.PHONY: all clean i686 Release before_i686 out_i686 clean_i686


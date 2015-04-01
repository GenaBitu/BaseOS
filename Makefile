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
ARCHDIR_I686 = $(SRCDIR)/arch/i686
OBJDIR_I686 = $(OBJDIR)/i686
BINDIR_I686 = $(BINDIR)/i686
ISODIR_I686 = $(ISODIR)/i686
OUT_I686 = $(BINDIR_I686)/BaseOS.bin
CRTI_I686 = $(OBJDIR_I686)/crti.o
CRTN_I686 = $(OBJDIR_I686)/crtn.o

CRTBEGIN = $(shell $(CC) $(CFLAGS) -print-file-name=crtbegin.o)
CRTEND = $(shell $(CC) $(CFLAGS) -print-file-name=crtend.o)

OBJLIST_I686 = $(OBJDIR_I686)/boot.o $(OBJDIR_I686)/kernel.o $(OBJDIR_I686)/tty.o
OBJ_I686 = $(CRTI_I686) $(CRTBEGIN) $(OBJLIST_I686) $(CRTEND) $(CRTN_I686)

all: i686

clean: clean_i686

i686: before_i686 out_i686

before_i686:
	test -d $(BINDIR_I686) || mkdir -p $(BINDIR_I686)
	test -d $(OBJDIR_I686) || mkdir -p $(OBJDIR_I686)

out_i686: $(OBJ_I686) $(LDSCRIPT)
	$(LD) -T $(LDSCRIPT) -o $(OUT_I686) $(LDFLAGS_I686) $(OBJ_I686) $(LDFLAGS_I686)

$(OBJDIR_I686)/boot.o: $(ARCHDIR_I686)/boot.asm
	$(AS) $(ASFLAGS_I686) $(ARCHDIR_I686)/boot.asm -o $(OBJDIR_I686)/boot.o

$(OBJDIR_I686)/crti.o: $(ARCHDIR_I686)/crti.asm
	$(AS) $(ASFLAGS_I686) $(ARCHDIR_I686)/crti.asm -o $(OBJDIR_I686)/crti.o

$(OBJDIR_I686)/crtn.o: $(ARCHDIR_I686)/crtn.asm
	$(AS) $(ASFLAGS_I686) $(ARCHDIR_I686)/crtn.asm -o $(OBJDIR_I686)/crtn.o

$(OBJDIR_I686)/kernel.o: $(SRCDIR)/kernel.c
	$(CC) -c $(SRCDIR)/kernel.c -o $(OBJDIR_I686)/kernel.o $(CFLAGS_I686)

$(OBJDIR_I686)/tty.o: $(ARCHDIR_I686)/tty.c
	$(CC) -c $(ARCHDIR_I686)/tty.c -o $(OBJDIR_I686)/tty.o $(CFLAGS_I686)

clean_i686:
	rm -rf $(OBJDIR_I686) $(BINDIR_I686) $(ISODIR_I686)

.PHONY: all clean i686 Release before_i686 out_i686 clean_i686


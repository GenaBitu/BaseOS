TARGET = i686-elf

AS = nasm
LD = GCC-$(TARGET)/bin/$(TARGET)-gcc
CC = GCC-$(TARGET)/bin/$(TARGET)-gcc

LDSCRIPT = linker.ld

ASFLAGS = -felf32
LDFLAGS = -ffreestanding -O2 -nostdlib
LDLIBS = -lgcc
CFLAGS = -std=gnu99 -ffreestanding -O2 -Wall -Wextra
SRCDIR = src
OBJDIR = obj
BINDIR = bin
ISODIR = iso

ASFLAGS_RELEASE = $(ASFLAGS)
LDFLAGS_RELEASE = $(LDFLAGS)
LDLIBS_RELEASE = $(LDLIBS)
CFLAGS_RELEASE = $(CFLAGS)
SRCDIR_RELEASE = $(SRCDIR)
OBJDIR_RELEASE = $(OBJDIR)/release
BINDIR_RELEASE = $(BINDIR)/release
ISODIR_RELEASE = $(ISODIR)/release
OUT_RELEASE = $(BINDIR_RELEASE)/BaseOS.bin

OBJ_RELEASE = $(OBJDIR_RELEASE)/boot.o $(OBJDIR_RELEASE)/kernel.o

all: release

clean: clean_release

release: before_release out_release

Release: release

before_release:
	test -d $(BINDIR_RELEASE) || mkdir -p $(BINDIR_RELEASE)
	test -d $(OBJDIR_RELEASE) || mkdir -p $(OBJDIR_RELEASE)

out_release: $(OBJ_RELEASE)
	$(LD) -T $(LDSCRIPT) -o $(OUT_RELEASE) $(LDFLAGS_RELEASE) $(OBJ_RELEASE) $(LDFLAGS_RELEASE)

$(OBJDIR_RELEASE)/boot.o: $(SRCDIR_RELEASE)/boot.asm
	$(AS) $(ASFLAGS_RELEASE) $(SRCDIR_RELEASE)/boot.asm -o $(OBJDIR_RELEASE)/boot.o

$(OBJDIR_RELEASE)/kernel.o: $(SRCDIR_RELEASE)/kernel.c
	$(CC) -c $(SRCDIR_RELEASE)/kernel.c -o $(OBJDIR_RELEASE)/kernel.o $(CFLAGS_RELEASE)

clean_release:
	rm -rf $(OBJDIR_RELEASE) $(BINDIR_RELEASE) $(ISODIR_RELEASE)

.PHONY: all clean release Release before_release out_release clean_release


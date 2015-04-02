#!/bin/bash

mkdir -p iso/i686
mkdir -p isodir
mkdir -p isodir/boot
mkdir -p isodir/boot/grub
cp kernel/bin/i686/BaseOS.bin isodir/boot/BaseOS.bin
cp grub.cfg isodir/boot/grub/grub.cfg
grub-mkrescue -o iso/i686/BaseOS.iso isodir
rm -fr isodir


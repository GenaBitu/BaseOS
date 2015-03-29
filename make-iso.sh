#!/bin/bash

mkdir -p iso/release
mkdir -p isodir
mkdir -p isodir/boot
mkdir -p isodir/boot/grub
cp bin/release/BaseOS.bin isodir/boot/BaseOS.bin
cp grub.cfg isodir/boot/grub/grub.cfg
grub-mkrescue -o iso/release/BaseOS.iso isodir
rm -fr isodir


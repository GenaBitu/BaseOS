#!/bin/bash
# Installs all needed development apps, compiles a cross-compiler to BaseOS, sets up QEMU.
# Written for Ubuntu, other distros might need minor changes (replacing apt with yum etc.).

DEPENDENCIES="build-essential libgmp-dev texinfo qemu xorriso"
TARGET="i686-elf"
PREFIX=$(pwd)"/GCC-"$TARGET
export PATH="$PREFIX/bin:$PATH"

BINUTILS="binutils-2.25"
GCC="gcc-4.9.2"
GMP="gmp-6.0.0a"
MPFR="mpfr-3.1.2"
MPC="mpc-1.0.3"
ISL="isl-0.12.2"
CLOOG="cloog-0.18.1"
TEXINFO="texinfo-5.2"

sudo apt-get update
sudo apt-get install -y $DEPENDENCIES

# Compile a GCC cross-compiler to i686-elf
mkdir -p build
cd build

wget -N http://ftpmirror.gnu.org/binutils/$BINUTILS.tar.gz
echo "Extracting $BINUTILS"
tar xf $BINUTILS.tar.gz
rm -f $BINUTILS.tar.gz

wget -N http://ftpmirror.gnu.org/gcc/$GCC/$GCC.tar.gz
echo "Extracting $GCC"
tar xf $GCC.tar.gz
rm -f $Gcc.tar.gz

wget -N http://ftpmirror.gnu.org/gmp/$GMP.tar.xz
echo "Extracting $GMP"
tar xf $GMP.tar.xz
rm -f $GMP.tar.xz

wget -N http://ftpmirror.gnu.org/mpfr/$MPFR.tar.xz
echo "Extracting $MPFR"
tar xf $MPFR.tar.xz
rm -f $MPFR.tar.xz

wget -N http://ftpmirror.gnu.org/mpc/$MPC.tar.gz
echo "Extracting $MPC"
tar xf $MPC.tar.gz
rm -f $MPC.tar.gz

wget -N ftp://gcc.gnu.org/pub/gcc/infrastructure/$ISL.tar.bz2
echo "Extracting $ISL"
tar xf $ISL.tar.bz2
rm -f $ISL.tar.bz2

wget -N ftp://gcc.gnu.org/pub/gcc/infrastructure/$CLOOG.tar.gz
echo "Extracting $CLOOG"
tar xf $CLOOG.tar.gz
rm -f $CLOOG.tar.gz

cd $BINUTILS
ln -s ../$ISL isl
ln -s ../$CLOOG cloog
cd ..

cd $GCC
ln -s ../$GMP gmp
ln -s ../$MPFR mpfr
ln -s ../$MPC mpc
ln -s ../$ISL isl
ln -s ../$CLOOG cloog
cd ..

mkdir build-binutils
mkdir build-gcc

cd build-binutils
../$BINUTILS/configure --target=$TARGET --prefix=$PREFIX --with-sysroot --disable-nls --disable-werror
make
make install
cd ..

cd build-gcc
../$GCC/configure --target=$TARGET --prefix="$PREFIX" --disable-nls --enable-languages=c,c++ --without-headers
make all-gcc
make all-target-libgcc
make install-gcc
make install-target-libgcc
cd ..

cd ..
rm -fr build

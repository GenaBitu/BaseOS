# Multiboot header constants.
.set ALIGN,	1		# align loaded modules on page boundaries
.set MEMINFO,	2		# provide memory map
.set FLAGS,	ALIGN | MEMINFO	# multiboot flags
.set MAGIC,	0x1BADB002	# magic number - needed in order for bootloader to find the kernel
.set CHECKSUM,	-(MAGIC + FLAGS)

# Multiboot header. See Multiboot specifications for more detail.
.section .multiboot
.align	4
.long	MAGIC
.long	FLAGS
.long	CHECKSUM

# Set up stack to point at free space instead of undefined place.
.section .bootstrap_stack, "aw", @nobits
stack_bottom:
.skip 16384			# 16 KiB
stack_top:

# The code itself.
.section .text
.global _start			# Linker entry point
.type _start, @function
_start:
	# Set up stack point register %esp to point at the empty stack created earlier.
	movl $stack_top,	%esp

	call	kernel_early
	call	kernel_main

	# In case kernel_main returns, the computer will be put into an infinite loop
	cli			# Disable interrupts
	hlt			# Stop CPU
.hang:				# Infinite loop
	jmp .hang

# Set the size of the _start symbol to the current location '.' minus _start location.
.size _start, . - _start


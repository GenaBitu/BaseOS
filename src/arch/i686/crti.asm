.section	.init
.global	_init
.type _init,	@function
_init:
	push	%ebp
	movl %esp,	%ebp
	# GCC will automatically put .init section from crtbegin.o here.

.section	.fini
.global	_fini
.type _fini,	@function
_fini:
	push	%ebp
	movl %esp,	%ebp
	# GCC will automatically put .fini section from crtbegin.o here.

.section	.init
	# GCC will automatically put .init section from crtend.o here.
	popl	%ebp
	ret

.section	.fini
	# GCC will automatically put .fini section from crtend.o here.
	popl	%ebp
	ret


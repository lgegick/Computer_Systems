# Hello World Test by Luke Gegick using MIPS Assembly

.data
		
helloString:	.asciiz		"Hello World\n"

	.text

	.globl main
				
main:
		la	$a0, helloString
		li	$v0, 4
		
		syscall		# print the string according to syscall 4
		
		jr 	$ra		# return to the caller
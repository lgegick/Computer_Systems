# Practice learning MIPS assembly
# This practice focuses on loops and accessing data

				.data 
declare_A:		.asciiz 	"The elements of array A are: "
declare_B:		.asciiz 	"The elements of array B are: "

Array_A:		.word		0, 1, 2, 3, 4, 5, 6, 7, 8, 9
Array_B:		.word		10, 11, 12, 13, 14, 15, 16, 17, 18, 19
size_A:			.word 		10

				.text
				
				.globl main
				
main:
		# push the stack
		addi 	$sp, $sp, -56

		# set up the array so we can loop through its elements
		la		$s1, Array_A
		la 		$t3, size_A
		lw 		$s2, 0($t3) 
		
		# print out text to show values of a
		la 		$a0, declare_A
		jal 	print_string

		# print the array
		jal 	print_array

		# add back to the stack
		addi 	$sp, $sp, 56
		
		# exit the PROGRAM
		li 		$v0, 10
		syscall
	
# Setup for this procedure
#s1: the base address of the array
#s2: the size of the array
print_array:
		# save the previous registers 
		addi 	$sp, $sp, -56
		sw 		$t0, 0($sp)
		sw 		$t1, 4($sp)
		sw 		$t2, 8($sp)

		# zero out all of the registers needed for computation
		move 	$t0, $zero 
		move 	$t1, $zero 
		move 	$t2, $zero

whlLop:	beq		$t0, $s2, Exit 
		add		$t1, $t0, $zero 	# put the size into t1 
		sll		$t1, $t1, 2			# multiply the index by 4
		add 	$t2, $s1, $t1

		# print the value at $t2 
		lw 		$a0, 0($t2)
		jal 	print_int

		# increment $t0 and continue the loop until out of index range
		addi 	$t0, $t0, 1
		j 		whlLop

Exit:
		# pop the values from the stack pointer 
		lw 		$t0, 0($sp)
		lw 		$t1, 4($sp)
		lw 		$t2, 8($sp)
		addi 	$sp, $sp, 56

		# return 
		jr 		$ra 

# print an int value, value to be printed must be in $a0
print_int:
		li		$v0, 1
		syscall
		jr		$ra
	
# print a char value, value to be printed must be in $a0
print_char:
		li 		$v0, 11
		syscall
		jr		$ra 
		
# print a string value, address must be given to register $a0
print_string:
		li 		$v0, 4
		syscall
		jr 		$ra
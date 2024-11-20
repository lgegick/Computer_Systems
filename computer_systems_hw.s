# Luke Gegick: homework for Computer Systems

				.data 
# QUESTION 1 SPECIFIC STRINGS TO PRINT OUT NECESSARY DATA
declareQ1:		.asciiz "-------Q1--------\n"
Q1: 			.asciiz	"USING FORMULA (f = h - i + 23)\nThe result of f = " 
info_grab_str:	.asciiz "ENTER INTS INTO THE RESPECTIVE VARIABLES\n"
h_string:		.asciiz "h = "
i_string:		.asciiz "i = "
f_string:		.asciiz "f = "
g_string:		.asciiz "g = "
answer_print:	.asciiz " is: "
equal_print:	.asciiz " = "
plus_string:	.asciiz " + "
minus_string:	.asciiz " - "

# QUESTION 2 SPECIFIC STRINGS TO PRINT OUT NECESSARY DATA
declareQ2:		.asciiz "\n\n-------Q2--------\n"
j_string:		.asciiz "j = "
display_A:		.asciiz	"A: 11, 12, 13, 14, 15, 16\n"
display_B:		.asciiz "B : 1, 2, 3, 4, 5, 6\n"
info_grab_str2:	.asciiz "ENTER i and j TO SOLVE FOR THE INDEX OF A[?] USING (A[i-j])\n"
invalid_index:	.asciiz "\n-- INVALID INDEX PRESENTED, EXITTING PROGRAM --\n"
B_index_value:	.asciiz "\nB[5] = "

# QUESTION 3 SPECIFIC STRINGS TO PRINT OUT NECESSARY DATA
declareQ3:		.asciiz "\n\n-------Q3--------\n"
frst_C_stmnt:	.asciiz "\nf = g + h + B[2] = "
scnd_C_stmnt:	.asciiz "\nf = g - A[B[3]] = "

# needed variables for calculations
f:				.word		0
h:				.word		0
i:				.word		0
J:				.word		0
g:				.word		0
A:				.word		11, 12, 13, 14, 15, 16
B:				.word		1,   2,  3,  4,  5,  6
new_index:		.word		0
derefnced_val:	.word		0

				.text
	
				.globl main
	
main:
	# QUESTION 1
	
	la		$a0, declareQ1
	jal		print_string
	
	# set up for the first calculations
	la 		$a0, info_grab_str
	jal		print_string
	
	# pull the value for h from the user
	la		$a0, h_string
	jal		print_string
	li		$v0, 5
	syscall
	la		$a0, h
	sw		$v0, 0($a0)
	
	# pull the value for i from the user
	la		$a0, i_string
	jal		print_string
	li		$v0, 5
	syscall
	la		$a0, i
	sw		$v0, 0($a0)
	
	# load the values into their respective VARIABLES
	lw		$s0, f
	lw 		$s1, h
	lw		$s2, i
	
	# complete the calucation and print out the answer
	sub		$s0, $s1, $s2		### PART OF ANSWER ON THE WORD DOCUMENT
	addi	$s0, $s0, 23		### PART OF ANSWER ON THE WORD DOCUMENT
	
	# print the answer string
	la 		$a0, Q1
	jal 	print_string
	
	# print the value of h
	move	$a0, $s1
	jal 	print_int
	
	# print the minus string
	la		$a0, minus_string
	jal		print_string
	
	# print the value of i
	move	$a0, $s2
	jal		print_int
	
	# print the plus string
	la		$a0, plus_string
	jal		print_string
	
	# print the literal 23
	li		$a0, 23
	jal		print_int
	
	# print the answer_print text
	la		$a0, answer_print
	jal		print_string
	
	# print the answer int
	move	$a0, $s0
	jal		print_int
	
	# print the newline characters
	li		$a0, '\n'
	jal 	print_char
	
	############################################################
	# QUESTION 2
	############################################################
	
	la		$a0, declareQ2
	jal		print_string
	
	la		$a0, display_A
	jal		print_string
	
	la		$a0, display_B
	jal		print_string
	
	# set up for the first calculations
	la 		$a0, info_grab_str2
	jal		print_string
	
	# pull the value for i from the user
	la		$a0, i_string
	jal		print_string
	li		$v0, 5
	syscall
	la		$a0, i
	sw		$v0, 0($a0)
	lw		$s6, 0($a0)
	
	# pull the value for J from the user
	la		$a0, j_string
	jal		print_string
	li		$v0, 5
	syscall
	la 		$a0, J
	sw		$v0, 0($a0)
	lw		$s7, 0($a0)
	
	# put the base address of A and B in x10 ($s0) and x11 ($s1) respectively
	la		$s0, A
	la		$s1, B
	
	# print all of the data entered by the user 
	move	$a0, $s6
	jal		print_int
	la		$a0, minus_string
	jal		print_string
	move	$a0, $s7
	jal		print_int
	la		$a0, answer_print
	jal		print_string
	
	# CALCULATE and print the value of i - J
	sub		$t0, $s6, $s7  ### PART OF ANSWER ON THE WORD DOCUMENT
	move	$a0, $t0
	jal		print_int
	
	# check the value of the new_index to avoid segmentation fault
	blt		$t0, 0, print_bad_index
	bgt		$t0, 6, print_bad_index
	
	# put the value of A[i - J] in B[5]
    sll     $t0, $t0, 2		### PART OF ANSWER ON THE WORD DOCUMENT
	add		$t0, $s0, $t0	### PART OF ANSWER ON THE WORD DOCUMENT
	lw		$t1, 0($t0)		### PART OF ANSWER ON THE WORD DOCUMENT
	sw		$t1, 20($s1)	### PART OF ANSWER ON THE WORD DOCUMENT
	
	# PRINT B[5]
	la		$a0, B_index_value
	jal		print_string
	lw		$t2, 0($s1)
	addi	$t2, $s1, 20
	lw		$a0, 0($t2)
	jal		print_int
	
	############################################################
	# QUESTION 3 	
	############################################################
	
	# clear the temp registers to avoid any data issues
	move	$t0, $zero
	move	$t1, $zero
	move	$t2, $zero
	move	$t3, $zero
	move 	$t4, $zero
	
	# set the variables f, g, h, and i to set up f=g+h+B[2]
	
	la 		$a0, declareQ3
	jal		print_string
	
	la		$a0, display_A
	jal		print_string
	
	la		$a0, display_B
	jal		print_string
	
	la		$a0, info_grab_str
	jal		print_string
	
	# pull f value from the user
	la		$a0, f_string
	jal		print_string
	li		$v0, 5
	syscall
	la		$a0, f
	sw		$v0, 0($a0)
	lw		$s0, 0($a0)
	
	# pull g value from the user
	la		$a0, g_string
	jal		print_string
	li		$v0, 5
	syscall
	la		$a0, g
	sw		$v0, 0($a0)
	lw		$s1, 0($a0)
	
	# pull h value from the user
	la		$a0, h_string
	jal		print_string
	li		$v0, 5
	syscall
	la		$a0, h
	sw		$v0, 0($a0)
	lw		$s2, 0($a0)
	
	# pull i value from the user
	la		$a0, i_string
	jal		print_string
	li		$v0, 5
	syscall
	la		$a0, i
	sw		$v0, 0($a0)
	lw		$s3, 0($a0)
	
	# pull J value from the user
	la		$a0, j_string
	jal		print_string
	li		$v0, 5
	syscall
	la		$a0, J
	sw		$v0, 0($a0)
	lw		$s4, 0($a0)
	
	# Store array A in $s5, and B in $s6
	la		$s5, A
	la		$s6, B 
	
	# Write the code to compute f = g + h + B[2]
	add		$t0, $s1, $s2 		### PART OF ANSWER ON THE WORD DOCUMENT
	lw		$t1, 8($s6)			### PART OF ANSWER ON THE WORD DOCUMENT
	add		$s0, $t0, $t1 		### PART OF ANSWER ON THE WORD DOCUMENT
	
	# display the first C result 
	la		$a0, frst_C_stmnt
	jal		print_string
	move	$a0, $s0
	jal		print_int
	
	# Write the code to compute f = g - A[B[3]]
	lw		$t1, 12($s6)		### PART OF ANSWER ON THE WORD DOCUMENT
	sll		$t1, $t1, 2			### PART OF ANSWER ON THE WORD DOCUMENT
	add		$t1, $s5, $t1		### PART OF ANSWER ON THE WORD DOCUMENT
	lw		$t2, 0($t1)			### PART OF ANSWER ON THE WORD DOCUMENT
	sub		$s0, $s1, $t2		### PART OF ANSWER ON THE WORD DOCUMENT
	
	# display second C result
	la		$a0, scnd_C_stmnt
	jal		print_string
	move	$a0, $s0
	jal		print_int
	
	# exit the PROGRAM
	li 		$v0, 10
	syscall
	
print_bad_index:
	la 		$a0, invalid_index
	jal		print_string
	jr		$ra
	
print_int:
	li		$v0, 1
	syscall
	jr		$ra
	
print_char:
	li 		$v0, 11
	syscall
	jr		$ra
	
print_string:
	li		$v0, 4
	syscall
	jr		$ra
	
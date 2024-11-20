# bit packing test

# we want to pack the bits of a month in the form
# DDDD DMMM MYYY YYYY ( word 2 byte data size )

	.data

compacted_msg:	.asciiz		"The packed date is: "
unpacked_mes:	.asciiz		"The unpacked date is: "
test_msg:		.asciiz		"Enter a number: "
test_msg2:		.asciiz     "User entered: "
day_msg:		.asciiz 	"Enter a day (0-31): "
bad_day_msg:	.asciiz		"Day value exceeds range\n"
month_msg:		.asciiz 	"Enter a month (1-12): "
bad_month_msg:	.asciiz		"Month value exceeds range\n"
year_msg:		.asciiz		"Enter a year (00-99): "
bad_year_msg:	.asciiz		"Year value exceeds range\n"
date_msg:		.asciiz  	"Date: "
nl:				.asciiz		"\n"

# variables to handle the data being held
day:			.half		0
month:			.byte		0
year: 			.half		0
packed_date:	.word		0

	.text
	
	.globl main
	
main:

	# get the day from the User
	la $a0, day_msg
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0
	
	# check the bounds of the day
	blt $t0, 0, print_bad_day
	bgt $t0, 31, print_bad_day
	
	sh $t0, day # store the half value of the day into the day variable
	
	# get the month from the User
	la $a0, month_msg
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0
	
	# check the bounds of the month
	blt $t0, 1, print_bad_month
	bgt $t0, 12, print_bad_month
	
	sb $t0, month
	
	# get the year from the user
	la $a0, year_msg
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0
	
	# check the bounds of the year value
	blt $t0, 0, print_bad_year
	bgt $t0, 99, print_bad_year
	
	sh $t0, year
	
	# CHECK THE VARIABLE VALUES
	
	la $a0, date_msg
	li $v0, 4
	syscall
	
	lh $a0, day
	li $v0, 1
	syscall
	
	li $a0, '/'
	li $v0, 11
	syscall
	
	lb $a0, month
	li $v0, 1
	syscall
	
	li $a0, '/'
	li $v0, 11
	syscall

	lh $a0, year
	li $v0, 1
	syscall
	
	la $a0, nl
	li $v0, 4
	syscall
	
	# pack the variables into the variable 
	li $t1, 0xFFFF0000  # Clear the lower 8 bits of $t0
	and $t0, $t0, $t1
	
	lb $t1, day		# load and handle the day value
	or $t0, $t0, $t1
	sll	$t0, $t0, 5
	
	lb $t1, month	# load and handle the month value
	or $t0, $t0, $t1
	sll $t0, $t0, 4
	
	lb $t1, year	# load and handle the year value
	or $t0, $t0, $t1
	sh $t0, packed_date
	
	# print the packed date
	la $a0, compacted_msg
	li $v0, 4
	syscall
	
	lh $a0, packed_date
	li $v0, 1
	syscall	
	
	jr $ra          # return to caller
	
print_bad_day:
	la $a0, bad_day_msg
	li $v0, 4
	syscall
	jr $ra
	
print_bad_month:
	la $a0, bad_month_msg
	li $v0, 4
	syscall
	jr $ra
	
print_bad_year:
	la $a0, bad_year_msg
	li $v0, 4
	syscall
	jr $ra
	
# Function to print out a newline, takes no arguments
print_newline: 
	la $a0, newline
	li $v0, 4
	syscall
	jr $ra 
	
# Function to print a '/', takes no arguments
print_slash:
	li $a0, '/'
	li $v0, 11
	syscall
	jr $ra 
	
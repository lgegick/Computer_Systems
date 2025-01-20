# Luke Gegick, Homework 2 for computer systems Section 2

                .data  
# Data needed to answer question 1
state_I:        .asciiz "Values of Index: "
state_X:        .asciiz "\nX = "
state_Y:        .asciiz "\nY = "
B:              .word   10
x:              .word   0
y:              .word   0

# Additional Data needed to answer question 2
question_2:     .asciiz "\n\n************ QUESTION 2 **************\n"
A:              .byte   'H', 'e', 'l', 'l', 'o', 0
BB:             .space  6
state_A:        .asciiz "\nValue of A: "
state_B:        .asciiz "\nValue of B: "

                .text

                .globl main
main: 
        ############ Question 1 ##############

        # print out the array text
        la      $a0, state_I
        jal     print_string

        # set up registers to run the for loop
        lw      $t0, x
        lw      $t1, y 
        lw      $t2, B 
        move    $t3, $zero      # make I equal to 0

        # run the for loop
frloop: beq     $t2, $t3, Exit      # check i < B
        addi    $t0, $t0, 1         # x += 1;
        addi    $t1, $t1, -2        # y -= 2;
        addi    $t3, $t3, 1         # increment i
        j       frloop

Exit:
        # print the index
        move    $a0, $t3
        jal     print_int

        # print the value of X
        la      $a0, state_X
        jal     print_string
        move    $a0, $t0 
        jal     print_int

        # print the value of Y
        la      $a0, state_Y
        jal     print_string
        move    $a0, $t1 
        jal     print_int

        ############ Question 2 ##############

        la      $a0, question_2
        jal     print_string

        # load the values for the procedure call
        la      $a1, A 
        la      $a3, BB         # refer to BB as 'B'

        jal     strCopy

        # print the values of A
        la      $a0, state_A
        jal     print_string
        move    $a0, $a1 
        jal     print_string

        # print the values of B
        la      $a0, state_B
        jal     print_string
        move    $a0, $a3 
        jal     print_string

        # exit the PROGRAM
        li 		$v0, 10
        syscall

strCopy:
        # adjust the stack to save register $s1
        addi    $sp, $sp, -4 
        sw      $s1, 0($sp) 
        move    $s1, $zero      # j = 0
L1:     add     $t1, $s1, $a1   # address of A[j]
        lbu     $t2, 0($t1)     # load byte unsinged from A[j]
        add     $t3, $s1, $a3   # address of B[j]
        sb      $t2, 0($t3)     # save A[j] to B[j]
        beq     $t2, $zero, L2  # leave loop if reached null terminator
        addi    $s1, $s1, 1     # increment j 
        j       L1 
L2:     
        lw      $s1, 0($sp)     # retrieve the old $s1 value and adjust the stack
        addi    $sp, $sp, 4
        jr      $ra 

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

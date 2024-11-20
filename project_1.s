# MIPS project 1

            .data
q1_decl:    .asciiz     "****QUESTION 1*****\n"
array:      .word       11, 22, 33, 44, 55, 66
a:          .word       0
value_decl: .asciiz     "A = "

q2_decl:    .asciiz     "\n*****QUESTION 2*****\n"
vectorA:    .word       2, 3, 4, 5
vectorB:    .word       4, 5, 6, 7
result:     .word       0
value2_decl:.asciiz     "Dot Product = "

            .text

            .globl main
main:

#############################################################
# QUESITON 1
#############################################################

        # show question 1 decl
        la      $a0, q1_decl
        jal     print_string

        # set up the for loop boundaries
        la      $t6, a          # move a into $t6
        sw      $zero, 0($t6)
        move    $t0, $zero      # set i to 0
        li      $t1, 6          # load the max value to iterate through
frloop: beq     $t0, $t1, Exit
        la      $t2, array      # load the base array into $t2
        sll     $t3, $t0, 2     # move the increment to represent an index
        add     $t4, $t2, $t3   # move the base array to the index we want to see (array + offset)
        lw      $t5, 0($t4)     # save the value in this location to $t5
        add     $t7, $t7, $t5   # a = a + arr[i]
        sw      $t7, 0($t6)     # save the value in variable 'a'
        addi    $t0, $t0, 1     # increment the loop
        j       frloop          # go back to the for loop

Exit:
        # print the value of A
        la      $a0, value_decl
        jal     print_string

        lw      $a0, a
        jal     print_int

#############################################################
# QUESITON 2
#############################################################

        la      $a0, q2_decl
        jal     print_string

        # set register for holding the dot product
        move    $t0, $zero      # load the value to increment the value 0
        li      $t1, 4          # load the max value we iterate through
        la      $t4, vectorA    # load the base address for vectorA
        la      $t5, vectorB    # load the base address for vectorB
frloop2:beq     $t0, $t1, Exit2
        lw      $t6, 0($t4)     # get the value at index for vectorA
        lw      $t7, 0($t5)     # get the value at index for vectorB
        mul     $t8, $t6, $t7   # multiply $t6 and $t7 storing it in $t8
        add     $t9, $t9, $t8   # add the multiplied value and store at $t9
        addi    $t4, $t4, 4     # get the next index for vectorA
        addi    $t5, $t5, 4     # get the next index for vectorB
        addi    $t0, $t0, 1     # increment the loop
        j       frloop2         # go back to the start
Exit2:

        # print the result for debugging
        la      $a0, value2_decl
        jal     print_string
        move    $a0, $t9
        jal     print_int

        # exit the PROGRAM
		li 		$v0, 10
		syscall

# print an int a, a to be printed must be in $a0
print_int:
		li		$v0, 1
		syscall
		jr		$ra

# print a string a, address must be given to register $a0
print_string:
		li 		$v0, 4
		syscall
		jr 		$ra

print_char:
        li      $v0, 11
        syscall
        jr      $ra

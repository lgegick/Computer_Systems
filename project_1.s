# MIPS project 1

            .data
array:      .word       11, 22, 33, 44, 55, 66
a:          .word       0
value_decl: .asciiz     "\nA = "

vectorA:    .word       2, 3, 4, 5
vectorB:    .word       4, 5, 6, 7
value2_decl:.asciiz     "\nDot Product = "

            .text

            .globl main
main:

#############################################################
# QUESTION 1
#############################################################

        la      $t6, a          # move variable a into $t6
        sw      $zero, 0($t6)   # set a = 0
        la      $t2, array      # load the base address of the array
        move    $t0, $zero      # set i to 0

frloop: beq     $t0, 6, Exit    # branch if the i variable is equal to 6 (i < 6)
        lw      $t3, 0($t2)     # load the element at arr[i]
        add     $t7, $t7, $t3   # a = a + arr[i]
        sw      $t7, 0($t6)     # save the value in variable 'a'
        addi    $t2, $t2, 4     # move to next element in array
        addi    $t0, $t0, 1     # increment the loop
        j       frloop          # go back to the for loop

Exit:
        la      $a0, value_decl # load out 'A = ' for debugging clarity
        jal     print_string    # call procedure for printing a string
        lw      $a0, a          # load out the result of the for-loop computation
        jal     print_int       # call procedure for printing an int

#############################################################
# QUESTION 2
#############################################################

        move    $t0, $zero      # load the value (i) to increment the value 0
        li      $t9, 0          # set the result equal to 0
        la      $t4, vectorA    # load the base address for vectorA
        la      $t5, vectorB    # load the base address for vectorB

frloop2:beq     $t0, 4 Exit2    # branch if i increment is equal to 4 (i < 4)
        lw      $t6, 0($t4)     # get the value at index for vectorA
        lw      $t7, 0($t5)     # get the value at index for vectorB
        mul     $t8, $t6, $t7   # multiply $t6 and $t7 storing it in $t8
        add     $t9, $t9, $t8   # add the multiplied value and store at $t9
        addi    $t4, $t4, 4     # get the next index for vectorA
        addi    $t5, $t5, 4     # get the next index for vectorB
        addi    $t0, $t0, 1     # increment the loop (i++)
        j       frloop2         # repeat the loop
Exit2:
        la      $a0, value2_decl # load the string 'dot product =' for debugging clarity
        jal     print_string    # call procedure to output a string
        move    $a0, $t9        # load the value of the dot product between array A and B
        jal     print_int       # call procedure to output an int
        li      $a0, 10         # load a newline character
        jal     print_char      # call procedure to output a character

        # exit the PROGRAM
		li 		$v0, 10
		syscall

# print an int a, value to be printed must be in $a0
print_int:
		li		$v0, 1
		syscall
		jr		$ra

# print a string a, address must be given to register $a0
print_string:
		li 		$v0, 4
		syscall
		jr 		$ra

# print a char a, address must be given to register $a0
print_char:
        li      $v0, 11
        syscall
        jr      $ra

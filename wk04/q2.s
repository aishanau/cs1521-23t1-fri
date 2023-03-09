# This program prints out a danish flag, by
# looping through the rows and columns of the flag.
# Each element inside the flag is a single character.
# (i.e., 1 byte).
#
# (Dette program udskriver et dansk flag, ved at
# sløjfe gennem rækker og kolonner i flaget.)
#


FLAG_ROWS = 6
FLAG_COLS = 12


main:
main__flag_row_loop_init:
	li	$t0, 0

main__flag_row_loop_cond:
	bge	$t0, FLAG_ROWS, main__flag_row_loop_end

main__flag_col_loop_init:
	li	$t1, 0

main__flag_col_loop_cond:
	bge	$t1, FLAG_COLS, main__flag_col_loop_end

	# calculate our address for the flag[row][col]

	# BaseOffset + (row_index * MAX_COL + col_index) * BYTES_OF_ELEM
	la	$t2, flag
	mul	$t3, $t0, FLAG_COLS 	# row_index * MAX_COL 
	add	$t3, $t3, $t1		# (row_index * MAX_COL + col_index)
	mul	$t3, $t3, 1
	
	add	$t4, $t2, $t3		# final &flag[row][col]

	# load the char from memory - lb 
	lb	$a0, ($t4)

	# print the character 
	li	$v0, 11
	syscall

	addi	$t1, $t1, 1
	b	main__flag_col_loop_cond

main__flag_col_loop_end:

	la	$a0, '\n'
	li	$v0, 11
	syscall

	addi	$t0, $t0, 1
	b	main__flag_row_loop_cond

main__flag_row_loop_end:

	li	$v0, 0
	jr	$ra

	.data
flag:
	.byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
	.byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
    	.byte '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.'
    	.byte '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.'
    	.byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
    	.byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
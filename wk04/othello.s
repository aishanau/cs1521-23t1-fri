################################################################################
################################################################################
###                    PROVIDED FUNCTION — DO NOT CHANGE                     ###
################################################################################
################################################################################

################################################################################
# .TEXT <print_board>
# YOU DO NOT NEED TO CHANGE THE print_board FUNCTION
	.text
print_board:
	# Args: void
	#
	# Returns:  void
	#
	# Frame:    [$ra, $s0, $s1] # anything that you push/pop on the stack
	# Uses:     [$a0, $v0, $t2, $t3, $t4, $s0, $s1] # any register thats in your function (doesnt matter if saved or not) 
	# Clobbers: [$a0, $v0, $t2, $t3, $t4] (Uses - Frame) 
	#
	# Locals:
	#   - $s0: col
	#   - $s1: row
	#   - $t2: board_size, row + 1
	#   - $t3: &board[row][col]
	#   - $t4: board[row][col]
	#
	# Structure:
	#   print_board
	#   -> [prologue]
	#   -> body
	#      -> header_loop
	#      -> header_loop__init
	#      -> header_loop__cond
	#      -> header_loop__body
	#      -> header_loop__step
	#      -> header_loop__end
	#      -> for_row
	#      -> for_row__init
	#      -> for_row__cond
	#      -> for_row__body
	#          -> print_row_num
	#          -> for_col
	#          -> for_col__init
	#          -> for_col__cond
	#          -> for_col__body
	#              -> white
	#              -> black
	#              -> possible_move
	#              -> output_cell
	#          -> for_col__step
	#          -> for_col__end
	#      -> for_row__step
	#      -> for_row__end
	#   -> [epilogue]

print_board__prologue:
	begin
	push	$ra
	push	$s0
	push	$s1

print_board__body:
	li	$v0, 4
	la	$a0, board_str
	syscall						# printf("Board:\n   ");

print_board__header_loop:
print_board__header_loop__init:
	li	$s0, 0					# int col = 0;

print_board__header_loop__cond:
	lw	$s1, board_size
	bge	$s0, $s1, print_board__header_loop__end # while (col < board_size) {

print_board__header_loop__body:
	li	$v0, 11
	addi	$a0, $s0, 'A'
	syscall						#     printf("%c", 'A' + col);

	li	$a0, ' '
	syscall						#     putchar(' ');

print_board__header_loop__step:
	addi	$s0, $s0, 1				#     col++;
	b	print_board__header_loop__cond		# }

print_board__header_loop__end:
	li	$v0, 11
	li	$a0, '\n'
	syscall						# printf("\n");

print_board__for_row:
print_board__for_row__init:
	li	$s0, 0					# int row = 0;

print_board__for_row__cond:
	lw	$t2, board_size
	bge	$s0, $t2, print_board__for_row__end	# while (row < board_size) {

print_board__for_row__body:
	addi	$t2, $s0, 1
	bge	$t2, 10, print_board__print_row_num	#     if (row + 1 < 10) {

	li	$v0, 11
	li	$a0, ' '
	syscall						#         printf("%d ", row + 1);

print_board__print_row_num:				#     }
	li	$v0, 1
	move	$a0, $t2
	syscall						#     printf("%d", row + 1);

	li	$v0, 11
	li	$a0, ' '
	syscall						#     putchar(' ');

print_board__for_col:
print_board__for_col__init:
	li	$s1, 0					#     int col = 0;

print_board__for_col__cond:
	lw	$t2, board_size
	bge	$s1, $t2, print_board__for_col__end	#     while (col < board_size) {

print_board__for_col__body:
	mul	$t3, $s0, MAX_BOARD_SIZE		#         &board[row][col] = row * MAX_BOARD_SIZE
	add	$t3, $t3, $s1				#                            + col
	addi	$t3, board				#                            + &board

	lb	$t4, ($t3)				#         char cell = board[row][col];

	beq	$t4, PLAYER_WHITE, print_board__white	#         if (cell == PLAYER_WHITE) goto print_board__white;
	beq	$t4, PLAYER_BLACK, print_board__black	#         if (cell == PLAYER_BLACK) goto print_board__black;

	move	$a0, $s0
	move	$a1, $s1
	jal	is_valid_move
	bnez	$v0, print_board__possible_move		#         if (is_valid_move(row, col)) goto print_board__possible_move;

	li	$a0, EMPTY_CELL_CHAR			#         c = EMPTY_CELL_CHAR;
	b	print_board__output_cell		#         goto print_board__output_cell;

print_board__white:
	li	$a0, WHITE_CHAR				#         c = WHITE_CHAR;
	b	print_board__output_cell		#         goto print_board__output_cell;

print_board__black:
	li	$a0, BLACK_CHAR				#         c = BLACK_CHAR;
	b	print_board__output_cell		#         goto print_board__output_cell;

print_board__possible_move:
	li	$a0, POSSIBLE_MOVE_CHAR			#         c = POSSIBLE_MOVE_CHAR;
	b	print_board__output_cell		#         goto print_board__output_cell;

print_board__output_cell:
	li	$v0, 11
	syscall						#         printf("%c", c);

	li	$a0, ' '
	syscall						#         putchar(' ');

print_board__for_col__step:
	addi	$s1, $s1, 1				#         col++;
	b	print_board__for_col__cond		#     }

print_board__for_col__end:
	li	$v0, 11
	li	$a0, '\n'
	syscall						#     putchar('\n');

print_board__for_row__step:
	addi	$s0, $s0, 1				#     row++;
	b	print_board__for_row__cond		# }

print_board__for_row__end:
print_board__epilogue:
	pop	$s1
	pop	$s0
	pop	$ra
	end

	jr	$ra					# return;

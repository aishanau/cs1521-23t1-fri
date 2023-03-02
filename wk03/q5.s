# // A simple program that will read 10 numbers into an array

# #define N_SIZE 10

# #include <stdio.h>

# int main(void) {
#     int i = 0;
#     int numbers[N_SIZE] = {0};

#     
#     if (i >= N_SIZE) goto end;
#         scanf("%d", &numbers[i]);
#         i++;
#     end:
# }


N_SIZE = 10

# i is stored in $t0
main:
	li	$t0, 0				#     int i = 0;

main__scan_loop_cond:
	bge	$t0, N_SIZE, main__scan_loop_end

	li	$v0, 5
	syscall
	# number is currently in $v0

	la	$t1, numbers
	mul	$t2, $t0, 4
	add	$t3, $t1, $t2		# final address of &numbers[i] in $t3

	sw	$v0, ($t3)


	add	$t0, $t0, 1
	b	main__scan_loop_cond

main__scan_loop_end:

	li	$v0, 0
	jr	$ra


	.data 
numbers:
	.word 0:N_SIZE

# // A simple program that adds 42 to each element of an array

# #define N_SIZE 10

# int main(void) {
#     int i;
#     int numbers[N_SIZE] = {0, 1, 2, -3, 4, -5, 6, -7, 8, 9};

#     i = 0;
#     while (i < N_SIZE) {
#         if (numbers[i] >= 0) goto end_if;
#             numbers[i] = numbers[i] + 42;
#         end_if:
#         i++;
#     }
# }
N_SIZE = 10


# i is stored in $t0
main:
	li	$t0, 0				#     int i = 0;

main__loop_cond:
	bge	$t0, N_SIZE, main__loop_end

    	la	$t1, numbers
	mul	$t2, $t0, 4
	add	$t3, $t1, $t2		# final address of &numbers[i] in $t3

    	# to get the value of numbers[i], use lw instruction 
    	lw  	$t4, ($t3)

	bge	$t4, 0, main__loop_number_gte_zero

	add	$t4, $t4, 42		# int tmp = numbers[i] + 42

	sw 	$t4, ($t3)		# numbers[i] = tmp;

main__loop_number_gte_zero:
	add	$t0, $t0, 1
	b	main__loop_cond

main__loop_end:

	li	$v0, 0
	jr	$ra


	.data 
numbers:         #     int numbers[N_SIZE] = {0, 1, 2, -3, 4, -5, 6, -7, 8, 9};
	.word 0, 1, 2, -3, 4, -5, 6, -7, 8, 9

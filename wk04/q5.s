
# #include <stdio.h>
# int sum4(int a, int b, int c, int d);
# int sum2(int x, int y);


# int main(void) {
#     int z = sum4(11, 13, 17, 19);
#     printf("%d\n", z);
#     return 0;
# }
main: 
main__prologue:
	begin
	push	$ra

main__body:

	li	$a0, 11
	li	$a1, 17
	li	$a2, 13
	li	$a3, 19
	jal	sum4

	move	$a0, $v0	# int result

	li	$v0, 1
	syscall

	la	$a0, '\n'
	li	$v0, 11
	syscall
	# $ra register points to this instruction once jal is called 

main__epilogue:
	pop 	$ra
	end

	li	$v0, 0
	jr	$ra




# int sum4(int a, int b, int c, int d) {
#     int res1 = sum2(a, b);
#     int res2 = sum2(c, d);
#     return sum2(res1, res2);
# }
sum4:

sum4__prologue:
	begin
	push	$ra
	push	$s0
	push	$s1
	push	$s2

sum4__body:
	move	$s1, $a2
	move	$s2, $a3

	jal	sum2
	move	$s0, $v0

	move 	$a0, $s1
	move 	$a1, $s2
	jal	sum2
	move	$t1, $v0

	move 	$a0, $s0
	move 	$a1, $t1
	jal	sum2

	# move	$v0, $v0
sum4__epilogue:
	pop	$s2
	pop	$s1
	pop	$s0
	pop 	$ra
	end

	jr	$ra

# int sum2(int x, int y) {
#     return x + y;
# }
sum2: 
	li	$t0, 100
	li	$t1, -5

	li	$a2, 100
	li	$a3, -5

	add	$v0, $a0, $a1
	jr	$ra
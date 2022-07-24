.data
A:	.word	7,-2,5,1,5,6,7,3,6,8,8,59,5
.text
	la	$a0, A		# a0 := dia chi A[0]
	li	$s0, 13		# do dai mang n:= 13
	j	sort		
complete:
	li	$v0, 10		# exit
	syscall
end_main:
	
#thuat toan sap xep chen
sort:
	li	$t0, 1		# i = 1
	li	$t1, 0		# j = 0
	li	$t2, 0		# key = 0
loop:
	slt	$v0, $t0, $s0
	beq	$v0, $0, end_loop	#neu i >= n thi end_loop
	sll	$t3, $t0, 2		# t3 = 4*i
	add	$t3, $t3, $a0		# lay dia chi A[i]
	lw	$t2, 0($t3)		# key = A[i]
	subi	$t1, $t0, 1		# j = i - 1
while:
	bltz 	$t1, end_while		#neu j < 0 thi end_while
	sll	$t4, $t1, 2		# t4 = 4*j
	add	$t4, $t4, $a0		# lay di chi A[j]
	lw	$t5, 0($t4)		# t5 = A[j]
	blt	$t2, $t5, end_while	# neu A[j] > key thi end_while
	sw	$t5, 4($t4)		# A[j+1] = A[j]
	subi	$t1, $t1, 1		# j = j - 1
	j	while
end_while:
	sll	$t4, $t1, 2		# t4 = 4*j
	add	$t4, $t4, $a0		# t4 := dia chi A[j+1]
	sw	$t2, 4($t4)		# A[j+1] = key
	addi	$t0, $t0, 1		# i = i + 1
	j	loop
end_loop:
	j	complete

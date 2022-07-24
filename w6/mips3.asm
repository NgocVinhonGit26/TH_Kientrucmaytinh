.data
A:	.word	7, -2, 5, 1, 5,6,7,3,6,8,8,59,5
.text
main:
	la	$a0, A	# $a0 := dia chi cua A[0]
	li	$s0, 13 # do dai mang n := 13
	j	sort
complete:
	li	$v0, 10	# exit
	syscall
end_main:


#Thuat toan sap xep bong bong
sort:
	li	$t0, 0	# i = 0	
loop1:
	slt	$v0, $t0, $s0
	beq	$v0, $0, end_loop1	# neu i >= n dung loop1
	li	$t1, 0			# j = 0
loop2:
	sub	$t2, $s0, 1
	sub	$t2, $t2, $t0		# t2 = n-i-1
	slt	$v0, $t1, $t2		
	beq	$v0, $0,	end_loop2		#neu j >= n-i-1 dung loop2
if:
	sll	$t5, $t1, 2		#t5 = 4*j (offset)
	add	$t5, $t5, $a0		#t5 := dia chi cua A[j]
	lw	$t3, 0($t5)		#t3 := A[j]
	lw	$t4, 4($t5)		#t4 := A[j+1]
	sgt	$v0, $t4, $t3		
	beq	$v0, $0, end_if		#neu A[j] >= A[j+1] thi end_if
	j	swap
end_if:
	addi	$t1, $t1, 1		# j = j + 1
	j	loop2
end_loop2:
	addi	$t0, $t0, 1		# i = i + 1
	j	loop1
end_loop1:
	j 	complete
swap:
	sw	$t3, 4($t5)
	sw	$t4, 0($t5)
	j	 end_if
	
	
	
	
	
	
	
	
	
	
	
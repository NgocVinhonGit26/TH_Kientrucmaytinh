.text
	addi $s1, $zero, 0x7fffffff
	addi $s2, $zero, 1
	li $t0, 0		# trang thai Not overflow
	addu $s3, $s1, $s2
	xor $t1, $s1, $s2	# check dau s1 va s2
	bltz $t1, EXIT
	xor $t1, $s1, $s3	# check dau s1 va s3
	bgtz $t1, EXIT         
OVERFLOW:
	li $t0, 1          #Overflow
EXIT:

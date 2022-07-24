.data
	input: .asciiz	""
	input_len: .word 0
	LA: .asciiz	" la"
	KHONG: .asciiz	" khong"
	DOIXUNG: .asciiz	" xau doi xung!"	

.text
main:
	la	$a0, input_len	# Load data
	lw	$a0, 0($a0)
	la	$a1, input
	jal 	ktradoixung	# kiem tra xau doi xung
	add	$a0, $v0, $0
	jal	printRes	# Print
	addi	$v0, $0, 10
	syscall			# Exit


ktradoixung:
	# kiem tra truong hop
	slti	$t0, $a0, 2
	bne	$t0, $0, returnTrue

	# so sanh ky tu dau va cuoi
	lb	$t0, 0($a1)
	addi	$t1, $a0, -1
	add	$t1, $t1, $a1
	lb	$t1, 0($t1)
	bne	$t0, $t1, returnFalse
	
	# thay doi con tro, do dai va quay lai vong lap
	addi	$a0, $a0, -2
	addi	$a1, $a1, 1
	j	ktradoixung
	
returnFalse:
	addi	$v0, $0, 0
	jr	$ra

returnTrue:
	addi	$v0, $0, 1
	jr	$ra

.text		
printRes:
	add	$t4, $a0, $0	# Stash result
	addi	$v0, $0, 4
	la	$a0, input
	syscall			# in xau
	la	$a0, LA
	syscall			# in "la"
	bne	$t4, $0, printResCont
	la 	$a0, KHONG  
		syscall		# in "khong"
printResCont:
	la	$a0, DOIXUNG
	syscall			# in "Xau doi xung!"
	jr	$ra

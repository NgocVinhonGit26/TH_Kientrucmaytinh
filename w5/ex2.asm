.data
	message1: .asciiz "\nThe sum of("
	message2: .asciiz ") and ("
	message3: .asciiz ") is ("
	message4: .asciiz ")\n("
.text
	li	$s0, 26		#s0 = 26
	li	$s1, 7		#s1 = 7
	add	$s2, $s0, $s1	#s2 = s0 + s1
	
	li	$v0, 4
	la	$a0, message1
	syscall
	
	li	$v0, 1
	add	$a0, $0, $s0
	syscall
	
	li	$v0, 4
	la	$a0, message2
	syscall
	
	li	$v0, 1
	add	$a0, $0, $s1
	syscall
	
	li	$v0, 4
	la	$a0, message3
	syscall
	
	li	$v0, 1
	add	$a0, $0, $s2
	syscall
	
	li	$v0, 4
	la	$a0, message4
	syscall
	
	

#Laboratory Exercise 5, Home Assignment 5
.data
	mes: .asciiz "Enter a character (press Enter to end): "
	str: .space 20
.text
init:
	add $s0, $zero, $zero
	la $s1, str
	
	li $v0, 4		
	la $a0, mes
	syscall
read:
	li $v0, 12			# input character
	la $a0, mes
	syscall
	nop
check:
	beq $v0, 10, print		# neu input = enter: nhay den print
	add $t1, $s0, $s1		# t1 = string[i]
	sb  $v0, 0($t1)			# v0 = t1 = string[i]
	addi $s0, $s0, 1			# i = i + 1
	slti $t0, $s0, 20
	beq $t0, $zero, print		# if i = 20: nhay den print
	j read
print:
	slt $t0, $s0, $zero		# for $s0 -> 0
	bne $t0, $zero, exit
	add $t1, $s0, $s1		# t1 = dia chi string[i]
	lb $t2, 0($t1)			# t2 = string[i]
	li $v0, 11
	add $a0, $zero, $t2		# print 	t2
	syscall
	addi $s0, $s0, -1		# i = i - 1
	j print
exit:
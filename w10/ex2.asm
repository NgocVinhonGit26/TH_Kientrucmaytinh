.eqv MONITOR_SCREEN 0x10010000
.eqv WHITE          0x00FFFFFF

.text
	li $k0, MONITOR_SCREEN
	addi $s0,$0,0
	addi $t2,$0,65
	addi $t3,$0,16
loop:
	beq $s0,$t2,endloop
	div $s0,$t3
	mfhi $t4
	addi $t7,$0,3
	addi $t6,$0,4
	addi $t5,$0,0
	beq $t4,$0,re1
	addi $s0,$s0,1
re2:
	beq $t5,$t6,loop
	sll $t1,$s0,2
	add $t1,$t1,$k0
	li $t0, WHITE
	sw  $t0, 0($t1)
	
	addi $s0,$s0,2
	beq $t5,$t7,re3
tang:
	addi $t5,$t5,1
	j re2
endloop:
re1:	
	beq $t5,$t6,loop
	sll $t1,$s0,2
	add $t1,$t1,$k0
	li $t0, WHITE
	sw  $t0, 0($t1)
	addi $s0,$s0,2
	addi $t5,$t5,1
	j	re1
re3:
	sub $s0,$s0,1
	j tang
exit:
	li    $v0, 10
	syscall
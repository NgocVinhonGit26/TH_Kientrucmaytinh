.eqv SEVENSEG_LEFT    0xFFFF0010	# Dia chi cua den led 7 doan trai.
				#     Bit 0 = doan a; 
				#     Bit 1 = doan b; ... 
				#     Bit 7 = dau .
.eqv SEVENSEG_RIGHT   0xFFFF0011	# Dia chi cua den led 7 doan phai
.data
mess: .asciiz "Nhap so nguyen:"

.text
main:	
	li $v0,51
	la $a0, mess
	syscall
	
	addi $s0,$0,10
	div $a0,$s0
	mfhi $t1
	mflo $t2
Left:	
	jal check
endLeft:
	jal   SHOW_7SEG_LEFT          # show
Right:
	div $t2,$s0
	mfhi $t1
	jal check
endRight:
	jal   SHOW_7SEG_RIGHT         # show   
exit:   li    $v0, 10
	syscall
endmain:
#---------------------------------------------------------------
# Function  SHOW_7SEG_LEFT : turn on/off the 7seg
# param[in]  $a0   value to shown       
# remark     $t0 changed
#---------------------------------------------------------------
SHOW_7SEG_LEFT: 	li   $t0,  SEVENSEG_LEFT # assign port's address
		sb   $a0,  0($t0)# assign new value
		jr   $ra
#---------------------------------------------------------------
# Function  SHOW_7SEG_RIGHT : turn on/off the 7seg
# param[in]  $a0   value to shown       
# remark     $t0 changed
#---------------------------------------------------------------
SHOW_7SEG_RIGHT: li   $t0,  SEVENSEG_RIGHT	# assign port's address
		sb   $a0,  0($t0	)	# assign new value
		jr   $ra
check:
	li $t8,0
	beq $t1,$t8,CASE0
	li $t8,1
	beq $t1,$t8,CASE1
	li $t8,2
	beq $t1,$t8,CASE2
	li $t8,3
	beq $t1,$t8,CASE3
	li $t8,4
	beq $t1,$t8,CASE4
	li $t8,5
	beq $t1,$t8,CASE5
	li $t8,6
	beq $t1,$t8,CASE6
	li $t8,7
	beq $t1,$t8,CASE7
	li $t8,8
	beq $t1,$t8,CASE8
	li $t8,9
	beq $t1,$t8,CASE9
CASE0:
	li $a0,0x3f
	jr $ra
CASE1:
	li $a0,0x6
	jr $ra
CASE2:
	li $a0,0x5b
	jr $ra
CASE3:
	li $a0,0x4f
	jr $ra
CASE4:
	li $a0,0x66
	jr $ra
CASE5:
	li $a0,0x6d
	jr $ra
CASE6:
	li $a0,0x7d
	jr $ra
CASE7:
	li $a0,0x7
	jr $ra
CASE8:
	li $a0,0x7f
	jr $ra
CASE9:
	li $a0,0x6f
	jr $ra
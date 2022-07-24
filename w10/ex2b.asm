.eqv MONITOR_SCREEN 0x10010000 
.eqv RED 0x00FF0000
.eqv GREEN 0x0000FF00
.eqv BLUE 0x000000FF
.eqv WHITE 0x00FFFFFF
.eqv YELLOW 0x00FFFF00
.data
Message1: .asciiz "Nhap hoanh do x1"
Message2: .asciiz "Nhap tung do y1" 
Message3: .asciiz "Nhap hoanh do x2" 
Message4: .asciiz "Nhap tung do y2" 
.text
main:
	li $v0, 51 # doc hoanh do x1 la $a0, Message1
	la $a0, Message1
	syscall
	addi $s1,$a0,0

	li $v0, 51 # doc tung do y1 la $a0, Message2
	la $a0, Message2
	syscall
	addi $s2,$a0,0
	li $v0, 51 # doc hoanh do x2 la $a0, Message3
	la $a0, Message3
	syscall
	addi $s3,$a0,0
	li $v0, 51 # doc tung do y2 la $a0, Message4
	la $a0, Message4
	syscall
	addi $s4,$a0,0
	li $k0, MONITOR_SCREEN 
check_hoanh:
	slt $t0,$s1,$s3 
	beqz $t0,luu1 
	addi $t4,$s1,0 
	addi $t5,$s3,0 
	j check_tung
luu1:
	addi $t4,$s3,0 
	addi $t5,$s1,0
check_tung:
	slt $t0,$s2,$s4 
	beqz $t0,luu2 
	addi $t6,$s2,0 
	addi $t7,$s4,0 
	j end_check
luu2:

	addi $t6,$s4,0
	addi $t7,$s2,0 
end_check:
	mul $s1,$t4,8 
	add $s1,$s1,$t6 
	mul $s1,$s1,4
	add $k0,$k0,$s1 
	sub $s2,$t5,$t4 
	sub $s3,$t7,$t6 
	addi $s2,$s2,1 
	addi $s3,$s3,1 
	mul $s4,$s3,4 
	mflo $s4
	li $s5,32
	sub $s5,$s5,$s4 
	li $t0, 0
	li $t1, 0
loop1:
	beq $t0, $s2, endloop1 
loop:
	beq $t1, $s3, endloop 
	li $t2, YELLOW
	sw $t2, 0($k0)
	addi $k0, $k0, 4
	addi $t1,$t1,1
	j loop
endloop:

	addi $t0,$t0,1
	li $t1, 0
	add $k0, $k0, $s5 
	j loop1 
endloop1:
	subi $k0, $k0, 32 
	addi $v0,$k0,0
	li $t0, 0
v1:
	beq $t0, $s3, endv1 
	li $t2, BLUE
	sw $t2, 0($v0)
	addi $v0, $v0, 4 
	addi $t0,$t0,1
	j v1
endv1:
	addi $v0,$k0,0
	li $t0, 0 
v2:
	beq $t0, $s2, endv2 
	li $t2, BLUE
	sw $t2, 0($v0)
	subi $v0, $v0, 32 
	addi $t0,$t0,1
	j v2
endv2:
	addi $v0,$v0,32 
	addi $k0,$v0,0

	li $t0, 0 
v3:
	beq $t0, $s3, endv3 
	li $t2, BLUE
	sw $t2, 0($k0)
	addi $k0, $k0, 4 
	addi $t0,$t0,1
	j v3
endv3:
	subi $k0,$k0,4
	li $t0, 0 
v4:
	beq $t0, $s2, endv4 
	li $t2, BLUE
	sw $t2, 0($k0)
	addi $k0, $k0, 32
	addi $t0,$t0,1
	j v4 
endv4: 
endmain:
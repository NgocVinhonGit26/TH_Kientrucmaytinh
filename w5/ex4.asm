.data
	string: .space 50
	Message1: .asciiz "Nhap xau: "
	Message2: .asciiz "Do dai la: "
.text
main: 
nhap_chuoi:
	li $v0, 54
	la $a0, Message1
	la $a1, string
	li $a2, 50 
	syscall
get_length:
	la  $a0, string			# a0 = dia chi string[0]
 	xor $v0, $zero, $zero		# length = 0
 	xor $t0, $zero, $zero		# i = 0
kt_kitu:
 	add  $t1, $a0, $t0		# t1 = i + string[0] (dia chi string[i])
 	lb   $t2, 0($t1)			# t2 = string[i]
 	beq  $t2,$zero,ket_thuc 		# kiem tra ki tu NULL
 	addi $v0, $v0, 1			# length = length+1
	addi $t0, $t0, 1			# i = i + 1
	j    kt_kitu
ket_thuc:
end_of_get_length:
	sub $v0, $v0, 1
ket_qua:
	add $a1, $zero, $v0
	li $v0, 56
	la $a0, Message2
	syscall
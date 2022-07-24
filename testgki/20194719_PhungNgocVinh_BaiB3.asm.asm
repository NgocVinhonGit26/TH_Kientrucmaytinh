
.data
	# array: .word -1, 150, 190, 170, -1, -1, 160, 180
	array: .space 4000	# Gioi han do dai cua mang la 1000 phan tu
	
	# Luu cac gia tri ra mot mang moi
	arr: .space 4000 
	message_input: .asciiz "Nhap gia tri phan tu mang !\n"
	message_input_length: .asciiz "Vui long nhap lai!"
	message_input_1: .asciiz "Nhap gia tri (cancel: ket thuc nhap)"
	message_input_2: .asciiz "Nhap sai gia tri dau vao. Vui long nhap lai!"
	message_input_3: .asciiz "Mang truoc khi sap xep:\n"
	space: 	.asciiz " "
	message_result: .asciiz "\nMang sau khi sap xep:\n"
	
	
.text
main:
	la 	$s1, array		# Lay dia chi cua array cho vao $s1
	la 	$s2, arr 		# Lay dia chi arr cho vao $s2
	addi 	$s3, $zero, 0		# $s3 = 0 
	
	addi 	$s4, $zero, 0		# n: So luong phan tu cua array
	addi 	$s5, $zero, 0		# m: So luong phan tu cua arr


### Input array
	li	$v0, 4
	la	$a0, message_input
	syscall
	
	jal	input
	nop
	
### Show input array
	li 	$v0, 4 
	la	$a0, message_input_3
	syscall
	
	jal	show_array
	nop

### Find arr
	jal	find_arr
	nop
	
### Sort arr
	jal 	sort_arr
	nop

### Change
	jal 	change
	nop

### in ket qua
	li 	$v0, 4 
	la	$a0, message_result
	syscall
	
	jal	show_array
	nop

### END
	li $v0, 10
	syscall
end_main:

# @input: Nhap cac gia tri tu ban phim
	
input:
	li $v0, 51
	la $a0, message_input_1
	syscall
	
	beq $a1, 0, input_ok		# Neu la int => oke
	beq $a1, -2, end_input		# Neu an cacel => ket thuc nhap
	
input_fail:
	li $v0, 55
	la $a0, message_input_2
	syscall
	j	input
	
	
input_ok:
	sll  	$t1, $s4, 2		# $t1 = 4*i
	add  	$t1, $t1, $s1		# Vi tri cua input[i]
	sw	$a0, 0($t1)
	addi 	$s4, $s4, 1		# i = i + 1
	j   	input

end_input:
	beqz	$s4, input_fail
	jr	$ra

input_length_fail:
	li 	$v0, 55
	la 	$a0, message_input_length
	syscall
	j	input
	
# @find_arr: Lay cac gia tri => arr

find_arr:

	# Khoi tao cac bien i, j bang 0
	addi 	$t0, $zero, 0		# i = 0
	addi 	$t2, $zero, 0		# j = 0

fh_loop:
	sll  	$t1, $t0, 2		# $t1 = 4*i
	add  	$t1, $t1, $s1		# Vi tri cua input[i]
	lw   	$s6, 0($t1)		# Lay gia tri cua input[i]
	
	ble  	$s6, $s3, fh_continue	# Neu gia tri input[i] <= -1 => continue
	
	sll  	$t3, $t2, 2		# $t3 = 4*j
	add  	$t3, $t3, $s2		# Vi tri cua arr[j]
	sw   	$s6, 0($t3)		# Luu gia tri vao vi tri arr[j]
	addi 	$t2, $t2, 1		# j = j + 1
	addi 	$s5, $s5, 1		# m = m + 1 (so luong phan tu trong arr tang len 1)
	
fh_continue:
	addi 	$t0, $t0, 1		# i = i + 1
	slt  	$t4, $t0, $s4		# if i < n => True: return 1; False: return 0
	bne  	$t4, $zero, fh_loop 

fh_end_loop:
	# j after_find_arr
	jr	$ra
			
#### Sap xep cac phan tu trong mang arr

sort_arr:

	# Khoi tao index i cua loop_1 bang 0 
	addi 	$t0, $zero, 0		# i = 0
	
loop_1:
	# Khoi tao index j cua loop_2 bang 0 
	addi  	$t1, $zero, 0		# j = 0
	
	addi 	$t0, $t0, 1		# i = i + 1
	sub 	$t2, $s5, $t0		# m - i - 1
	
	# Kiem tra dieu kien: i < m - 1
	slt 	$t6, $t0, $s5  
	beq 	$t6, $zero, end_loop_1
	
loop_2:
	# Kiem tra dieu kien j < m - i - 1
	slt 	$t5, $t1, $t2		#  j < m - i - 1: True return 1; else return 0 
	beq 	$t5, $zero, end_loop_2

	sll 	$t3, $t1, 2 		# $t3 = 4*j
	add 	$t3, $t3, $s2		# Vi tri cua A[j]
	lw  	$s6, 0($t3)		# Lay gia tri cua A[j]
	lw  	$s7, 4($t3)		# Lay gia tri cua A[j+1]
	
if:
	slt	 $t4, $s6, $s7 		# Kiem tra A[j] < A[j+1] => True: return 1; False: return 0
	bne 	$t4, $zero, end_if
	
	# Neu A[j] > A[j + 1] => swap	
   	sw 	$s7, 0($t3) 
    	sw 	$s6, 4($t3) 

end_if:
	addi 	$t1, $t1, 1		# j = j + 1
	j   	loop_2
	
end_loop_2:
	j   	loop_1
	
end_loop_1:
	jr	$ra

# change: Thay the nhung gia tri da duoc sap xep trong mang arr vao mang array

change:
	# Khoi tao bien i, j bang 0
	addi 	$t0, $zero, 0		# i = 0
	addi 	$t2, $zero, 0		# j = 0
	
i_loop:
	sll  	$t1, $t0, 2		# $t1 = 4*i
	add  	$t1, $t1, $s1		# Vi tri cua array[i]
	lw   	$s6, 0($t1)		# Lay gia tri cua array[i]
	
	ble  	$s6, $s3, i_continue	# Neu gia tri array[i] == -1 => continue
	
	sll  	$t3, $t2, 2		# $t3 = 4*j
	add  	$t3, $t3, $s2		# Vi tri cua arr[j]
	lw   	$s6, 0($t3)		# Lay gia tri cua arr[j]
	sw 	$s6, 0($t1)		# array[i] = arr[j]
	
	addi 	$s7, $zero, 0
	sw 	$s7, 0($t3)		# Reset gia tri cua arr[j] = 0
	addi 	$t2, $t2, 1		# j = j + 1

i_continue:
	addi 	$t0, $t0, 1		# i = i + 1
	slt  	$t4, $t0, $s4		# if i < n: True return: 1; False return: 0
	bne  	$t4, $zero, i_loop 

i_end_loop:
	jr	$ra

# @show_array: Hien thi array

show_array:
	addi 	$t0, $zero, 0		# i = 0
	
show_array_loop:
	sll  	$t1, $t0, 2		# $t1 = 4*i
	add  	$t1, $t1, $s1		# Vi tri cua input[i]
	lw   	$s6, 0($t1)		# Lay gia tri cua input[i]
	
	li	$v0, 4			# in dau cach
	la	$a0, space
	syscall
	li 	$v0, 1			# in gia tri
	addi	$a0, $s6, 0
	syscall
		
	addi 	$t0, $t0, 1		# i = i + 1
	slt  	$t4, $t0, $s4		# if i < n => True: return 1; False: return 0
	bne  	$t4, $zero, show_array_loop
end_show_array:
	jr	$ra


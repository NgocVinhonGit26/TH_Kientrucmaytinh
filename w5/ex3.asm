.data
	x: .space 32 			#khoi tao chuoi dich x, rong 
	y: .asciiz "Hello World" 	#chuoi nguon y
.text
strcpy:
	la 	$a0, x
	la	$a1, y
      	add   	$s0,$zero,$zero   	# i = 0
Loop:
	add	$t1,$s0,$a1 		# t1 = i + y[0] (dia chi y[i])
	lb	$t2, 0($t1)		# t2 = gia tri cua $t1 = y[i]
	add	$t3, $s0, $a0		# t3 = i + x[0] (dia chi x[i])
	sb 	$t2,0($t3)          	# x[i]= t2 = y[i]  
	beq 	$t2,$zero,end_of_strcpy 	#if y[i] = 0, exit  
   	nop 
    	addi 	$s0,$s0,1     		#i=i+1  
    	j 	Loop         
    	nop 
end_of_strcpy:
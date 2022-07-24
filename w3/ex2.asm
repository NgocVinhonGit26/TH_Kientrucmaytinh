.data 

arr: .word	6,-7,2001,38,42,-73 

  

.text 

	addi $s1, $zero, 0	#i = 0 

	la   $s2, arr	#load address A[i] 

	addi $s3, $zero, 6	#n = 6 

	addi $s4, $zero, 1	#step = 1 

	addi $s5, $zero, 0	#sum = 0 

loop:

	

	add  $t1,$s1,$s1	#$t1=2*$s1 

	add  $t1,$t1,$t1	#$t1=4*$s1 

	add  $t1,$t1,$s2	#$t1 store the address of A[i] 

	lw   $t0,0($t1)		#load value of A[i] in $t0 
	
	seq  $t2, $t0, $zero	# A[i] == 0 ? 1 : 0
	beq  $t2, $s4, endloop

	add  $s5,$s5,$t0	#sum=sum+A[i] 

	add  $s1,$s1,$s4	#i=i+step 

	j    loop		#goto loop 

endloop: 
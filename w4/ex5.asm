.text
	li	$s1,26		#gan s1 = 26
	li	$s2,8		#gan s2 = 8
	srl	$t0,$s2,1	#dich phai 1 bit
	li 	$t1,1		#count = 1
	
loop:	beq	$t0,1,enloop	#dk dung
	srl	$t0,$t0,1	#tipe tuc dich phai 1 bit
	addi	$t1,$t1,1	# t1 = t1 + 1
	j 	loop
enloop:
	sllv	$s3,$s1,$t1	#s3 = s1 * (2^count)
EXIT:
	
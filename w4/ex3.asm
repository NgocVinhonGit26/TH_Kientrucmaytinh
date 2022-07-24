.text
	li	$s1,26		#gan s1 = -26
	li	$s2,1		
	bltz	$s1,SOAM		# kiem tra dau cua s1
	add	$s0,$s1,$0
	j 	EXIT
SOAM:
	sub	$t0,$s1,$s2	#tru s1 cho 1
	not	$s0,$t0		#dao bit
EXIT:
	
	
	

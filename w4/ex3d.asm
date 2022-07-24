.text
	li	$s1,26		#gan s1 = 26
	li	$s2,75		#gan s2 = 7
	
	sub	$t0,$s1,$s2	#t0 = s1 - s2
	blez	$t0,LABEL	#t0 <= 0 ?
	j	EXIT
LABEL:
	li	$s3, 2001	#kiem tra
EXIT:
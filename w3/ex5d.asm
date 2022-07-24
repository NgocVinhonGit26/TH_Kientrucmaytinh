.data
     arr: .word 26, 7, -2001, -42, -73, -48, -500, 499, 123, 145
.text
     addi  $s1, $zero, 0    # i = 0
     la    $s2, arr         # load address A[i]
     addi  $s3, $zero, 10   # n = 10
     addi  $s4, $zero, 1    # step = 1
     addi  $s5, $zero, 0    # max = 0
     loop: 
          add  $s1, $s1, $s4    # i = i + step
          add  $t1,$s1,$s1	#$t1=2*$s1  
	  add  $t1,$t1,$t1	#$t1=4*$s1  
          add  $t1, $t1, $s2    # t1 store address of A[i]
          lw   $t0, 0($t1)      # load value of A[i] in $t0
          abs  $t2, $t0
          start: 
               sgt  $t3, $t2, $s5    # if A[i] > max
               beqz $t3, else        # if not then else
               add  $s5, $t2, $zero  # max = A[i]
               j endif
          else:
          endif: 
               blt  $s1, $s3, loop   # i <= n => loop again
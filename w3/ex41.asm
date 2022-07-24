.text 

     addi  $s1, $zero, 2     # i = 6 

     addi  $s2, $zero, 1     # j = 5 

     addi  $t1, $zero, 4     # x = $t1 

     addi  $t2, $zero, 3     # y = $t2 

     add   $t3, $zero, 4     # z = $t3 

     start: 

          slt   $t0, $s1, $s2      # i < j 

          bnez  $t0, else          # branch to else if i >= j   

          addi  $t1, $t1, 1        # then part: x = x + 1 

          addi  $t3, $zero, 1      # z = 1 

          j     endif              # skip else part 

     else:                         # begin else part 

          addi  $t2, $t2, -1       # y = y - 1 

          sll   $t3, $t3, 1        # z = 2 * z 

     endif:   
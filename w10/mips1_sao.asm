.eqv  HEADING    0xffff8010    # Integer: An angle between 0 and 359
# 0 : North (up)
# 90: East (right)
# 180: South (down)
# 270: West  (left)
.eqv  MOVING     0xffff8050   # Boolean: whether or not to move
.eqv  LEAVETRACK 0xffff8020    
# Boolean (0 or non-0):
#    whether or not to leave a track
.eqv  WHEREX     0xffff8030    # Integer: Current x-location of MarsBot
.eqv  WHEREY     0xffff8040    # Integer: Current y-location of MarsBot
.text  
main:  
addi  $a0, $zero, 135		# Marsbot rotates 135* and start running
jal   ROTATE
jal   GO
sleep1: addi    $v0,$zero,32    # Keep running by sleeping in4000 ms
li  $a0,4000        
syscall
jal     TRACK# and draw new track line
go1: addi    $a0, $zero, 90# Marsbot rotates 90*
jal     ROTATE
sleep2: addi $v0,$zero,32  # Keep running by sleeping in 4000 ms
li      $a0,4000        
syscall
jal     UNTRACK         # keep old track
jal     TRACK           # and draw new track line
go2: addi  $a0, $zero, 234# Marsbotrotates 234*  
jal   ROTATE
sleep3: addi    $v0,$zero,32    # Keep running by sleeping in 4000 ms
li      $a0,4000        
syscall
jal     UNTRACK         # keep old track
jal     TRACK           # anddraw new track line
go3: addi  $a0, $zero, 18 # Marsbotrotates 18*  
jal   ROTATE
sleep4: addi    $v0,$zero,32    # Keep running by sleeping in 4000 ms
li      $a0,4000        
syscall
jal     UNTRACK         # keep old track
jal     TRACK           # anddraw new track line
go4: addi  $a0, $zero, 162# Marsbotrotates 162*  
jal   ROTATE
sleep5: addi    $v0,$zero,32    # Keep running by sleeping in 4000 ms
li      $a0,4000        
syscall
jal     UNTRACK         # keep old track
jal     TRACK           # anddraw new track line
go5: addi  $a0, $zero, 306# Marsbotrotates 306*  
jal   ROTATE
sleep6: addi    $v0,$zero,32    # Keep running by sleeping in 4000 ms
li      $a0,4000        
syscall
jal     UNTRACK         # keep old track

end_main:
	li $v0, 10#exit
	syscall
#-----------------------------------------------------------
# GO procedure, to start running
# param[in]    none
#-----------------------------------------------------------
GO:     li    $at, MOVING     # change MOVING port
addi  $k0, $zero,1    # to  logic 1,
sb    $k0, 0($at)     # to start running
jr    $ra
#-----------------------------------------------------------
# STOP procedure, to stop running
# param[in]    none
#-----------------------------------------------------------
STOP:   li    $at, MOVING     # change MOVING port to 0
sb    $zero, 0($at)   # to stop
jr    $ra
#-----------------------------------------------------------
# TRACK procedure, to start drawing line 
# param[in]    none
#-----------------------------------------------------------
TRACK:  li    $at, LEAVETRACK # change LEAVETRACK port
addi  $k0, $zero,1    # to  logic 1,
sb    $k0, 0($at)     # to start tracking
jr    $ra
#-----------------------------------------------------------
# UNTRACK procedure, to stop drawing line
# param[in]    none
#-----------------------------------------------------------
UNTRACK:li    $at, LEAVETRACK # change LEAVETRACK port to 0
sb    $zero, 0($at)   # to stop drawing tail
jr    $ra
#-----------------------------------------------------------
# ROTATE procedure, to rotate the robot
# param[in]    $a0, An angle between 0 and 359
#                   0 : North (up)
#                   90: East  (right)
#                  180: South (down)
#                  270: West  (left)
#-----------------------------------------------------------
ROTATE: li    $at, HEADING    # change HEADING port
sw    $a0, 0($at)     # to rotate robot
jr    $ra

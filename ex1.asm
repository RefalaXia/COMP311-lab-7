.data 0x10000000 ##!
  display: 	.space 65536
  		.align 2
  redPrompt:	.asciiz "Enter a RED color value (integer in range 0-255):\n"
  greenPrompt:	.asciiz "Enter a GREEN color value (integer in range 0-255):\n"
  bluePrompt:	.asciiz "Enter a BLUE color value (integer in range 0-255):\n"


.text 0x00400000 ##!
main:

	addi	$v0, $0, 4  			# system call 4 is for printing a string
	la 	$a0, redPrompt 			# address of columnPrompt is in $a0
	syscall           			# print the string
	# read in the R value
	addi	$v0, $0, 5			# system call 5 is for reading an integer
	syscall 				# integer value read is in $v0
 	add	$s0, $0, $v0			# copy N into $s0
 	
 	
 	
 	addi	$v0, $0, 4  			# system call 4 is for printing a string
	la 	$a0, greenPrompt 		# address of columnPrompt is in $a0
	syscall           			# print the string
	# read in the G value
	addi	$v0, $0, 5			# system call 5 is for reading an integer
	syscall 				# integer value read is in $v0
 	add	$s1, $0, $v0			# copy N into $s1
 	
 	
 	
 	addi	$v0, $0, 4  			# system call 4 is for printing a string
	la 	$a0, bluePrompt 		# address of columnPrompt is in $a0
	syscall           			# print the string
	# read in the B value
	addi	$v0, $0, 5			# system call 5 is for reading an integer
	syscall 				# integer value read is in $v0
 	add	$s2, $0, $v0			# copy N into $s2
 	
 	
 	
 	
##################################################################################
##   Setup for drawing a white display    		                        ##
##################################################################################
 	# li $t0, 0
	# li $s3, 16384
	# li $t1, 0x00ffffff # = RGB(255,255,255)
	# j drawDisplay
##################################################################################	



##################################################################################
##   drawing a colored display                                                  ##
##################################################################################
	li $t0, 0		# load 0 into $t0
	li $s3, 16384		# set $s3 into 16384
	sll $s0, $s0, 16	# move Red into 16-23
	or $t1, $t1, $s0	# put $s0 (Red) into $t1
	sll $s1, $s1, 8		# move Green into 8-15
	or $t1, $t1, $s1	# put $s1 (Green) into $t1
	or $t1, $t1, $s2	# put $s2 (Blue) into $t1
	j drawDisplay		# call drawDisplay


	
drawDisplay:
	mul $t3, $t0, 4
	sw $t1, display($t3)
	addi $t0, $t0, 1
	bne $t0, $s3, drawDisplay

# Exit from the program
exit:
  ori $v0, $0, 10       		# system call code 10 for exit
  syscall               		# exit the program

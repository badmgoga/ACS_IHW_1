.data
	array_A: .space 64
	array_B: .space 64
	enter: .asciz "Enter the number of elements\n"
	error: .asciz "ERROR! Incorrect number of elements\n"
	space: .ascii " "
.include "IDZ_1_macros.asm"
.text
main:
	jal input_number
	
	la t0, array_A # the begin of array
	li t3, 4
	mul t2, a0, t3
	add t1, t0, t2  # the end of array
	addi sp, sp, -4
	sw t0, (sp) # save of the begin of array
	jal input_array
	lw t0, (sp)
	jal even_amount
	lw t0, (sp)
	addi sp, sp, 4
	
	la t5, array_B # begin of array_B
	jal create_new_array
	la t6, array_B # after "create_new_array" end of array - t5
	jal print_array
	
	li a7, 10
	ecall
	
input_number:
	input_number # number of elements
	
	li t1, 1   # bottom line (1)
	li t2, 10  # upper line (10)
	blt a0, t1, end
	bgt a0, t2, end
	mv t0, a0
	ret

input_array:
	input_array (t0, t1) # t0 - begin, t1 - end
	ret
	
even_amount: # calculating the sum of array elements at even places
	addi t0, t0, 4
	li t3, 0
while:
	bge t0, t1, skip
	lw t4, (t0)
	add t3, t3, t4
	addi t0, t0, 8
	j while
	skip:
	ret
	
create_new_array:
	create_new_array (t0, t1, t5) # t0 - begin, t1 - end, t5 - begin of array_B
	ret

print_array:
	print_array (t6, t5) # t6 - begin, t5 - end
	ret

end:
	li a7, 4
	la a0, error
	ecall
	li a7, 10
	ecall

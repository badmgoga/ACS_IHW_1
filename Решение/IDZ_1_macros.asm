.macro input_number
	la a0, enter 
	li a7, 4
	ecall
	li a7, 5
	ecall
.end_macro

.macro input_int
   	li a7, 5
   	ecall
.end_macro

.macro input_array %t %t_end
while:
	input_int
	sw a0, (%t)
	addi %t, %t, 4
	blt %t, %t_end, while
.end_macro

.macro create_new_array %t, %t_end, %t_new
while:
	lw t4, (%t)
	ble t3, t4, skip
	sw t4, (%t_new)
	addi %t_new, %t_new, 4
	skip:
	addi %t, %t, 4
	blt %t, %t_end, while
.end_macro

.macro print_array %t %t_end
while:
	bge %t, %t_end, skip
	lw a0, (%t)
	li a7, 1
	ecall
	la a0, space
	li a7, 4
	ecall
	addi %t, %t, 4
	j while
	skip:
.end_macro

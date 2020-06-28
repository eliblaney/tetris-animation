.global print_board
.extern clear

@ print_board
@
@ Prints the current state of the game board.
@
@ Params:
@ R8 -- Top half of board
@ R9 -- Bottom half of board
print_board:
push {R0-R10,LR} @ Save register contents

@ Clear the screen
bl clear

@ Print top edge of board
ldr R1,=edge
bl print

@ START PRINT_BOARD_LOOP0

@ print_board_loop0
@ Loops for each row (byte) of R8
@ Prints top half of board
mov R6,#0
print_board_loop0:

@ Print left edge of board
ldr R1,=left
bl print

@ R10 = bit mask for each row (byte) of R8
mov R10,#0xFF @ one byte = one row
@ Shift the bitmask to correct location of R8
mov R2,#8
mul R3,R2,R6
lsl R10,R3
@ Extract the correct byte of R8 into R4
and R4,R8,R10
@ Shift the byte to the least significant position
lsr R4,R3

@ START PRINT_BOARD_LOOP01

@ print_board_loop01
@ Will repeat for each column of the row
@ Prints " " for 0 and "#" for 1
mov R3,#8
print_board_loop01:
sub R3,R3,#1

@ Extract correct bit/column from byte/row
lsr R2,R4,R3
and R5,R2,#1
@ Print correct character
cmp R5,#0
ldreq R1,=empty
ldrne R1,=occupied
bl print

cmp R3,#0
bne print_board_loop01

@ END PRINT_BOARD_LOOP01

@ Print right side of board with newline
ldr R1,=right
bl print

add R6,R6,#1
cmp R6,#4
bne print_board_loop0

@ END PRINT_BOARD_LOOP0

@ START PRINT_BOARD_LOOP1

@ print_board_loop1
@ Everything from this point is like
@ print_board_loop0, But swapped for R9
mov R6,#0
print_board_loop1:

ldr R1,=left
bl print

mov R10,#0xFF @ one byte = one row
mov R2,#8
mul R3,R2,R6
lsl R10,R3
and R4,R9,R10
lsr R4,R3

@ START PRINT_BOARD_LOOP11

mov R3,#8
print_board_loop11:
sub R3,R3,#1

lsr R2,R4,R3
and R5,R2,#1
cmp R5,#0
ldreq R1,=empty
ldrne R1,=occupied
bl print

cmp R3,#0
bne print_board_loop11

@ END PRINT_BOARD_LOOP11

ldr R1,=right
bl print
add R6,R6,#1
cmp R6,#4
bne print_board_loop1

@ END PRINT_BOARD_LOOP1

ldr R1,=edge
bl print

pop {R0-R10,LR} @ Restore registers
bx LR @ Return to program

@ END print_board

.data
edge: .asciz "++++++++++\n" @ Top or bottom edge
left: .asciz "+" @ Left side edge
right: .asciz "+\n" @ Right side edge
empty: .asciz " " @ Empty space
occupied: .asciz "#" @ Occupied space

.end

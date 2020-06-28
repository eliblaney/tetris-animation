.global tick
.extern sleep_tick

@ tick(R8,R9)
@
@ Handles one tick of game time. Will animate blocks down.
@
@ Params:
@ R8 -- Top half of board
@ R9 -- Bottom half of board
tick:
push {R0-R7,LR}

bl sleep_tick @ Wait the desired tick time before moving on

lsl R9,#8 @ Move contents of R9 one row down the board
ldr R1,=#0xFF000000 @ Bitmask for bottom row
and R0,R8,R1 @ Mask R8 to get bottom row
lsr R0,#24 @ Move contents to least significant region
orr R9,R9,R0 @ Copy bottom row of R8 to top row of R9
lsl R8,#8 @ Move contents of R8 one row down the board
bl print_board

pop {R0-R7,LR}
bx LR

@ END tick

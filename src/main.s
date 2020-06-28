.global main

main:
ldr R8,=#0x00001c10 @ Initial state containing first block
bl print_board @ Display initial state

bl tick @ Each tick will sleep 0.8s and animate the block down
bl tick
lsl R8,#1 @ This will shift the board one bit left, effectively moving
lsl R9,#1 @ the block around. Alternatively, use lsr to move right.
bl tick
lsl R8,#1
lsl R9,#1
bl tick
lsl R8,#1
lsl R9,#1
bl tick
bl tick

@ Exit program
mov R0,#0
mov R7,#1
svc 0

.global print @ External subroutine entry for subroutine print

@ Subroutine print will display a string of characters
@ R1: Points to beginning of ASCII string
@ End of string will be marked by a null byte
@ LR: Contains the return address
@ All register contents will be preserved

print:
push {R0-R8,LR} @ Save contents of registers R0 through R8 and LR
sub R2,R1,#1    @ R2 will be index while searching string for null

hunt4z:
ldrb R0,[R2,#1]! @ Load next character, and increment R2 by 1
cmp R0,#0       @ Set z-status bit if null found
bne hunt4z      @ If not null, loop back to examine next character
subs R2,R1      @ Get number of bytes in msg (not counting null)
mov R0,#1       @ Code for stdout (output to display for monitor)
mov R7,#4       @ Command code to write string
svcne 0         @ Issue command to display string on stdout
pop {R0-R8,LR}  @ Restore saved register contents
bx LR           @ Return to the calling program
.end

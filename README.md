# Tetris Animation

Created by Eli Blaney as a final project for CSC 414, "Introduction to Computer Architecture," taught by Dr. Brian Kokensparger.

## Basic Info

This project was originally intended to create a simple, interactive Tetris game in ARM Assembly. Unfortunately, I did not have quite enough spare time to bring my ambitious project to fruition during the semester. So for now, this project draws a Tetris game board, and animates a classic Tetris block falling from the top of the board to the bottom, moving to the left as it falls. I may add more to this project in the future in my spare time.

## Usage

On a Raspberry Pi, the project can be compiled simply by invoking the Makefile with the following command:

	make

The program will be compiled to a "tetris" binary in the current directory, and it can be run by either of the following two commands:

	make run
	./tetris

To remove object files and program binaries, simply run the following command:

	make clean

## Code Design

The game board itself is encoded as a series of two 32-bit integers, stored in the registers R8 and R9. The board can be manipulated by shifting each register left 8 bits (one full row) to lower all of the occupied bits by one space. A left shift bit will move everything on the board to the left, while a right shift bit will move everything on the board to the right. I created this encoding for the board data because it made sense to me, and it seemed efficient, requiring only 8 bytes to store 64 pieces of data. A visual of this data is detailed below.

The animation is run by a series of ticks. A tick waits a certain period of time and then acts on all the data on the board in order to make blocks fall or any other game logic that needs to be performed. Unfortunately, certain actions like sleeping for a certain period of time or clearing the terminal screen are surprisingly difficult to implement in ARM Assembly, since the ARM architecture is designed to be platform-independent, and these are OS-specific features. Because of that, I used a small C file to greatly simplify these basic system tasks, but no game logic is actually written in C.

## Code Explanations

### board.s

    print_board(R8, R9)

Prints board using row data from R8 and R9.

Returns: Nothing.

	R1 = print argument
	R2 = temp var
	R3 = temp var, loop counter
	R4 = board byte block
	R5 = temp var
	R6 = temp var, loop counter
	R8 = board data (top half of board)
	R9 = board data (bottom half of board)
	R10 = bit mask

R8 and R9 each look like this:

	H00000000G F00000000E D00000000C B00000000A

	<----------------
	| B  00000000  A
	| D  00000000  C
	| F  00000000  E
	V H  00000000  G

A zero is an empty space (" ") on the board. A one is an occupied space ("#")

### tick.s

	tick(R8, R9)

Handles one tick of game time. It will animate blocks down.

Returns: New board data stored in R8 and R9.

	R0 = temp var
	R1 = bit mask
	R8 = board data (top half of board)
	R9 = board data (bottom half of board)

CC=gcc
AS=as
ENTRYPOINT=main
OUTPUT=./tetris

.PHONY: install

install:
	$(CC) -c util.c
	$(AS) -o main.o main.s
	$(AS) -o print.o print.s
	$(AS) -o board.o board.s
	$(AS) -o tick.o tick.s

	$(CC) -o $(OUTPUT) *.o -e $(ENTRYPOINT)

run:
	$(OUTPUT)

clean:
	rm -f *.o
	rm -f $(OUTPUT)

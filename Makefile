CC=gcc
AS=as
ENTRYPOINT=main
OUTPUT=./tetris

.PHONY: install

install:
	$(CC) -c src/util.c
	$(AS) -o main.o src/main.s
	$(AS) -o print.o src/print.s
	$(AS) -o board.o src/board.s
	$(AS) -o tick.o src/tick.s

	$(CC) -o $(OUTPUT) *.o -e $(ENTRYPOINT)

run:
	$(OUTPUT)

clean:
	rm -f *.o
	rm -f $(OUTPUT)

warnings=

all_without_test:
	make clean_all
	make reader
	make writer
	make clear
	make clean

all:
	make all_without_test
	make test

writer: writer.o utils.o
	gcc writer.o utils.o -o writer
	chmod +x writer
	make clean

reader: reader.o utils.o
	gcc reader.o utils.o -o reader
	chmod +x reader
	make clean

clear: clear.o utils.o
	gcc clear.o utils.o -o clear
	chmod +x clear
	make clean

writer.o: writer.c
	gcc -c writer.c $(warnings) -o writer.o

reader.o: reader.c
	gcc -c reader.c $(warnings) -o reader.o

clear.o: clear.c
	gcc -c clear.c $(warnings) -o clear.o

utils.o: utils.c
	gcc -c utils.c $(warnings) -o utils.o

clean:
	rm -rf *~ *.o

clean_all:
	make clean && rm -rf reader writer

test_write:
	./writer foo bar

test_read:
	./reader foo

test_read_undefined:
	./reader undefined

test_clear:
	./clear foo

test:
	make test_write
	make test_read_undefined
	make test_read
	make test_read
	make test_clear
	make test_read

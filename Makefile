warnings=

all:
	make clean_all
	make reader
	make writer
	make clear
	make clean
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

test:
	./writer foo bar
	./reader fooa
	./reader foo
	./reader foo
	./clear foo
	./reader foo

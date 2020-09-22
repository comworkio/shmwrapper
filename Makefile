warnings=

all_without_test:
	make clean_all
	make shmwrapper
	make clean

all:
	make all_without_test
	make test

shmwrapper: shmwrapper.o utils.o
	gcc shmwrapper.o utils.o -o shmwrapper
	chmod +x shmwrapper
	make clean

shmwrapper.o: shmwrapper.c
	gcc -c shmwrapper.c $(warnings) -o shmwrapper.o

utils.o: utils.c
	gcc -c utils.c $(warnings) -o utils.o

clean:
	rm -rf *~ *.o

clean_all:
	make clean && rm -rf shmwrapper

test_write:
	./shmwrapper -w foo bar

test_read:
	./shmwrapper -r foo

test_read_undefined:
	./shmwrapper -r undefined

test_clear:
	./shmwrapper -c foo

test_big_keys:
	./shmwrapper -w keyveryveryveryveryverylong value
	./shmwrapper -w keyveryveryveryveryverylong value2
	./shmwrapper -w keyveryveryveryveryveryverylong value3
	./shmwrapper -r keyveryveryveryveryverylong
	./shmwrapper -r keyveryveryveryveryveryverylong
	./shmwrapper -c keyveryveryveryveryverylong
	./shmwrapper -c keyveryveryveryveryveryverylong
	./shmwrapper -r keyveryveryveryveryverylong
	./shmwrapper -r keyveryveryveryveryveryverylong

test:
	make test_write
	make test_read_undefined
	make test_read
	make test_read
	make test_clear
	make test_read
	make test_big_keys

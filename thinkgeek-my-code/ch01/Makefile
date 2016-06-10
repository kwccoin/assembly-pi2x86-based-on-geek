# Makefile

all: first
 
first: first.o
	gcc -o $@ $+
 
first.o : first.s
	as -o $@ $<
	
run: first
	./first; echo $$? # not sure why 132 i.e CR 2 not just 2 

objdump: first.o
	objdump -d first.o

clean:
	rm -vf first *.o
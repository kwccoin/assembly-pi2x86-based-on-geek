# Makefile

all: load01 store01
 
load01: load01.o
	gcc -o $@ $+
 
load01.o : load01.s
	as -o $@ $<
	
run: load01 store01
	./load01; echo $$? # not sure why 132 i.e CR 2 not just 2 
	./store01; echo $$? # not sure why 132 i.e CR 2 not just 2 

objdump: load01.o store01
	objdump -d load01.o
	objdump -d store01.o

gdb1: load01
	# http://web.cecs.pdx.edu/~jrb/cs201/lectures/handouts/gdbcomm.txt
	# start
	# disas
	# info registers r0 r1 r2 r3
	# info all-registers
	# p $ro = 2
	# stepi / si
	# nexti / ni
	# p &myvar1
	# p myvar1
	# break function/line-no/file:line-no
	# watch expression
	# info breakpoint
	# bt
	# frame
	# info local
	# show commands
	# define caommand ... end
	# help running/run/info/info line/show/show coammnds
	gdb --args ./load01

store01: store01.o
	gcc -o $@ $+
 
store01.o : store01.s
	as -o $@ $<
	
gdb2: store01
	gdb --args ./store01

clean:
	rm -vf load01 *.o
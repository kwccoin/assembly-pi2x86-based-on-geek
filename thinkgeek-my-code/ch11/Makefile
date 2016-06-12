# Makefile

all: collatz1 collatz2
 
collatz1: collatz1.o
	gcc -o $@ $+
 
collatz1.o : collatz1.s
	as -o $@ $<
	
run: collatz1 collatz2
	./collatz1; echo $$? # not sure why 132 i.e CR 2 not just 2 
	./collatz2; echo $$? # not sure why 132 i.e CR 2 not just 2 

objdump: collatz1.o collatz2
	objdump -d collatz1.o
	objdump -d collatz2.o

gdb1: collatz1
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
	gdb --args ./collatz1

perf1: collatz1
	uname -a
	cat /proc/cpuinfo
	#perf stat -e cpu-cycles ./collatz1
	#yes 123 | perf stat --log-fd3--repeat=5 -e cpu-clock  ./collatz1 #3>&1
	yes 123 | perf stat --repeat=5 -e cpu-clock ./collatz1 #3>&1
	yes 123 | perf stat --repeat=5 -e cpu-cycles ./collatz1 #3>&1
	# not sure about the _branches
	# seems upgrade to 4.4 now running ok

collatz2: collatz2.o
	gcc -o $@ $+
 
collatz2.o : collatz2.s
	as -o $@ $<
	
gdb2: collatz2
	gdb --args ./collatz2

perf2: collatz2
	uname -a
	cat /proc/cpuinfo
	#perf stat -e cpu-cycles ./collatz2
	yes 123 | perf stat --repeat=5 -e cpu-clock  ./collatz2 #3>&1
	yes 123 | perf stat --repeat=5 -e cpu-cycles ./collatz2 #3>&1
	
	
	

clean:
	rm -vf collatz1 *.o
	rm -vf collatz2 *.o
/* -- store01.s */
 
/* -- Data section */
.data
 
/* Ensure variable is 4-byte aligned */
.balign 4
/* Define storage for myvar1 */
myvar1:
    /* Contents of myvar1 is just '3' */
    .word 0
 
/* Ensure variable is 4-byte aligned */
.balign 4
/* Define storage for myvar2 */
myvar2:
    /* Contents of myvar2 is just '3' */
    .word 0
 
/* -- Code section */
.text
 
/* Ensure function section starts 4 byte aligned */
.balign 4
.global main
main:
    ldr r1, addr_of_myvar1 /* r1 ← &myvar1 */
    mov r3, #3             /* r3 ← 3 */
    str r3, [r1]           /* *r1 ← r3 */
    ldr r2, addr_of_myvar2 /* r2 ← &myvar2 */
    mov r3, #4             /* r3 ← 4 */
    str r3, [r2]           /* *r2 ← r3 */
 
    /* Same instructions as above */
    ldr r1, addr_of_myvar1 /* r1 ← &myvar1 */
    ldr r1, [r1]           /* r1 ← *r1 */
    ldr r2, addr_of_myvar2 /* r2 ← &myvar2 */
    ldr r2, [r2]           /* r1 ← *r2 */
    add r0, r1, r2
    bx lr
 
/* Labels needed to access data */
addr_of_myvar1 : .word myvar1
addr_of_myvar2 : .word myvar2

/* 
pi@raspberrypi:~/ch03 $ make gdb2
gdb --args ./store01
GNU gdb (Raspbian 7.7.1+dfsg-5) 7.7.1
Copyright (C) 2014 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "arm-linux-gnueabihf".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
<http://www.gnu.org/software/gdb/documentation/>.
For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from ./store01...(no debugging symbols found)...done.
(gdb) start
Temporary breakpoint 1 at 0x103e8
Starting program: /home/pi/ch03/store01 

Temporary breakpoint 1, 0x000103e8 in main ()
(gdb) print .data
A syntax error in expression, near `.data'.
(gdb) disass /r 
Dump of assembler code for function main:
=> 0x000103e8 <+0>:	28 10 9f e5	ldr	r1, [pc, #40]	; 0x10418 <addr_of_myvar1>
   0x000103ec <+4>:	03 30 a0 e3	mov	r3, #3
   0x000103f0 <+8>:	00 30 81 e5	str	r3, [r1]
   0x000103f4 <+12>:	20 20 9f e5	ldr	r2, [pc, #32]	; 0x1041c <addr_of_myvar2>
   0x000103f8 <+16>:	04 30 a0 e3	mov	r3, #4
   0x000103fc <+20>:	00 30 82 e5	str	r3, [r2]
   0x00010400 <+24>:	10 10 9f e5	ldr	r1, [pc, #16]	; 0x10418 <addr_of_myvar1>
   0x00010404 <+28>:	00 10 91 e5	ldr	r1, [r1]
   0x00010408 <+32>:	0c 20 9f e5	ldr	r2, [pc, #12]	; 0x1041c <addr_of_myvar2>
   0x0001040c <+36>:	00 20 92 e5	ldr	r2, [r2]
   0x00010410 <+40>:	02 00 81 e0	add	r0, r1, r2
   0x00010414 <+44>:	1e ff 2f e1	bx	lr
End of assembler dump.
(gdb) disass /r +2-
A syntax error in expression, near `'.
(gdb) disass /r +20
No function contains specified address.
(gdb) disass /r 0x000103e8,+20
Dump of assembler code from 0x103e8 to 0x103fc:
=> 0x000103e8 <main+0>:	28 10 9f e5	ldr	r1, [pc, #40]	; 0x10418 <addr_of_myvar1>
   0x000103ec <main+4>:	03 30 a0 e3	mov	r3, #3
   0x000103f0 <main+8>:	00 30 81 e5	str	r3, [r1]
   0x000103f4 <main+12>:	20 20 9f e5	ldr	r2, [pc, #32]	; 0x1041c <addr_of_myvar2>
   0x000103f8 <main+16>:	04 30 a0 e3	mov	r3, #4
End of assembler dump.
(gdb) disass /r 0x000103e8,+80
Dump of assembler code from 0x103e8 to 0x10438:
=> 0x000103e8 <main+0>:	28 10 9f e5	ldr	r1, [pc, #40]	; 0x10418 <addr_of_myvar1>
   0x000103ec <main+4>:	03 30 a0 e3	mov	r3, #3
   0x000103f0 <main+8>:	00 30 81 e5	str	r3, [r1]
   0x000103f4 <main+12>:	20 20 9f e5	ldr	r2, [pc, #32]	; 0x1041c <addr_of_myvar2>
   0x000103f8 <main+16>:	04 30 a0 e3	mov	r3, #4
   0x000103fc <main+20>:	00 30 82 e5	str	r3, [r2]
   0x00010400 <main+24>:	10 10 9f e5	ldr	r1, [pc, #16]	; 0x10418 <addr_of_myvar1>
   0x00010404 <main+28>:	00 10 91 e5	ldr	r1, [r1]
   0x00010408 <main+32>:	0c 20 9f e5	ldr	r2, [pc, #12]	; 0x1041c <addr_of_myvar2>
   0x0001040c <main+36>:	00 20 92 e5	ldr	r2, [r2]
   0x00010410 <main+40>:	02 00 81 e0	add	r0, r1, r2
   0x00010414 <main+44>:	1e ff 2f e1	bx	lr
   0x00010418 <addr_of_myvar1+0>:	b8 05 02 00			; <UNDEFINED> instruction: 0x000205b8
   0x0001041c <addr_of_myvar2+0>:	bc 05 02 00			; <UNDEFINED> instruction: 0x000205bc
   0x00010420 <__libc_csu_init+0>:	f8 43 2d e9	push	{r3, r4, r5, r6, r7, r8, r9, lr}
   0x00010424 <__libc_csu_init+4>:	00 70 a0 e1	mov	r7, r0
   0x00010428 <__libc_csu_init+8>:	4c 60 9f e5	ldr	r6, [pc, #76]	; 0x1047c <__libc_csu_init+92>
   0x0001042c <__libc_csu_init+12>:	4c 50 9f e5	ldr	r5, [pc, #76]	; 0x10480 <__libc_csu_init+96>
   0x00010430 <__libc_csu_init+16>:	06 60 8f e0	add	r6, pc, r6
   0x00010434 <__libc_csu_init+20>:	05 50 8f e0	add	r5, pc, r5
End of assembler dump.
(gdb) disass /r 0x000205b8,+20
Dump of assembler code from 0x205b8 to 0x205cc:
   0x000205b8:	00 00 00 00	andeq	r0, r0, r0
   0x000205bc:	00 00 00 00	andeq	r0, r0, r0
   0x000205c0 <completed.9004+0>:	00 00 00 00	andeq	r0, r0, r0
   0x000205c4:	00 00 00 00	andeq	r0, r0, r0
   0x000205c8:	00 00 00 00	andeq	r0, r0, r0
End of assembler dump.
(gdb) si
0x000103ec in main ()
(gdb) disass /r 0x000205b8,+40
Dump of assembler code from 0x205b8 to 0x205e0:
   0x000205b8:	00 00 00 00	andeq	r0, r0, r0
   0x000205bc:	00 00 00 00	andeq	r0, r0, r0
   0x000205c0 <completed.9004+0>:	00 00 00 00	andeq	r0, r0, r0
   0x000205c4:	00 00 00 00	andeq	r0, r0, r0
   0x000205c8:	00 00 00 00	andeq	r0, r0, r0
   0x000205cc:	00 00 00 00	andeq	r0, r0, r0
   0x000205d0:	00 00 00 00	andeq	r0, r0, r0
   0x000205d4:	00 00 00 00	andeq	r0, r0, r0
   0x000205d8:	00 00 00 00	andeq	r0, r0, r0
   0x000205dc:	00 00 00 00	andeq	r0, r0, r0
End of assembler dump.
(gdb) disass /r 0x000103e8,+80
Dump of assembler code from 0x103e8 to 0x10438:
   0x000103e8 <main+0>:	28 10 9f e5	ldr	r1, [pc, #40]	; 0x10418 <addr_of_myvar1>
=> 0x000103ec <main+4>:	03 30 a0 e3	mov	r3, #3
   0x000103f0 <main+8>:	00 30 81 e5	str	r3, [r1]
   0x000103f4 <main+12>:	20 20 9f e5	ldr	r2, [pc, #32]	; 0x1041c <addr_of_myvar2>
   0x000103f8 <main+16>:	04 30 a0 e3	mov	r3, #4
   0x000103fc <main+20>:	00 30 82 e5	str	r3, [r2]
   0x00010400 <main+24>:	10 10 9f e5	ldr	r1, [pc, #16]	; 0x10418 <addr_of_myvar1>
   0x00010404 <main+28>:	00 10 91 e5	ldr	r1, [r1]
   0x00010408 <main+32>:	0c 20 9f e5	ldr	r2, [pc, #12]	; 0x1041c <addr_of_myvar2>
   0x0001040c <main+36>:	00 20 92 e5	ldr	r2, [r2]
   0x00010410 <main+40>:	02 00 81 e0	add	r0, r1, r2
   0x00010414 <main+44>:	1e ff 2f e1	bx	lr
   0x00010418 <addr_of_myvar1+0>:	b8 05 02 00			; <UNDEFINED> instruction: 0x000205b8
   0x0001041c <addr_of_myvar2+0>:	bc 05 02 00			; <UNDEFINED> instruction: 0x000205bc
   0x00010420 <__libc_csu_init+0>:	f8 43 2d e9	push	{r3, r4, r5, r6, r7, r8, r9, lr}
   0x00010424 <__libc_csu_init+4>:	00 70 a0 e1	mov	r7, r0
   0x00010428 <__libc_csu_init+8>:	4c 60 9f e5	ldr	r6, [pc, #76]	; 0x1047c <__libc_csu_init+92>
   0x0001042c <__libc_csu_init+12>:	4c 50 9f e5	ldr	r5, [pc, #76]	; 0x10480 <__libc_csu_init+96>
   0x00010430 <__libc_csu_init+16>:	06 60 8f e0	add	r6, pc, r6
   0x00010434 <__libc_csu_init+20>:	05 50 8f e0	add	r5, pc, r5
End of assembler dump.
(gdb) si
0x000103f0 in main ()
(gdb) disass /r 0x000205b8,+20
Dump of assembler code from 0x205b8 to 0x205cc:
   0x000205b8:	00 00 00 00	andeq	r0, r0, r0
   0x000205bc:	00 00 00 00	andeq	r0, r0, r0
   0x000205c0 <completed.9004+0>:	00 00 00 00	andeq	r0, r0, r0
   0x000205c4:	00 00 00 00	andeq	r0, r0, r0
   0x000205c8:	00 00 00 00	andeq	r0, r0, r0
End of assembler dump.
(gdb) disass /r 0x000103e8,+60
Dump of assembler code from 0x103e8 to 0x10424:
   0x000103e8 <main+0>:	28 10 9f e5	ldr	r1, [pc, #40]	; 0x10418 <addr_of_myvar1>
   0x000103ec <main+4>:	03 30 a0 e3	mov	r3, #3
=> 0x000103f0 <main+8>:	00 30 81 e5	str	r3, [r1]
   0x000103f4 <main+12>:	20 20 9f e5	ldr	r2, [pc, #32]	; 0x1041c <addr_of_myvar2>
   0x000103f8 <main+16>:	04 30 a0 e3	mov	r3, #4
   0x000103fc <main+20>:	00 30 82 e5	str	r3, [r2]
   0x00010400 <main+24>:	10 10 9f e5	ldr	r1, [pc, #16]	; 0x10418 <addr_of_myvar1>
   0x00010404 <main+28>:	00 10 91 e5	ldr	r1, [r1]
   0x00010408 <main+32>:	0c 20 9f e5	ldr	r2, [pc, #12]	; 0x1041c <addr_of_myvar2>
   0x0001040c <main+36>:	00 20 92 e5	ldr	r2, [r2]
   0x00010410 <main+40>:	02 00 81 e0	add	r0, r1, r2
   0x00010414 <main+44>:	1e ff 2f e1	bx	lr
   0x00010418 <addr_of_myvar1+0>:	b8 05 02 00			; <UNDEFINED> instruction: 0x000205b8
   0x0001041c <addr_of_myvar2+0>:	bc 05 02 00			; <UNDEFINED> instruction: 0x000205bc
   0x00010420 <__libc_csu_init+0>:	f8 43 2d e9	push	{r3, r4, r5, r6, r7, r8, r9, lr}
End of assembler dump.
(gdb) disass /r 0x000205b8,+20
Dump of assembler code from 0x205b8 to 0x205cc:
   0x000205b8:	00 00 00 00	andeq	r0, r0, r0
   0x000205bc:	00 00 00 00	andeq	r0, r0, r0
   0x000205c0 <completed.9004+0>:	00 00 00 00	andeq	r0, r0, r0
   0x000205c4:	00 00 00 00	andeq	r0, r0, r0
   0x000205c8:	00 00 00 00	andeq	r0, r0, r0
End of assembler dump.
(gdb) si
0x000103f4 in main ()
(gdb) disass /r 0x000205b8,+20
Dump of assembler code from 0x205b8 to 0x205cc:
   0x000205b8:	03 00 00 00	andeq	r0, r0, r3
   0x000205bc:	00 00 00 00	andeq	r0, r0, r0
   0x000205c0 <completed.9004+0>:	00 00 00 00	andeq	r0, r0, r0
   0x000205c4:	00 00 00 00	andeq	r0, r0, r0
   0x000205c8:	00 00 00 00	andeq	r0, r0, r0
End of assembler dump.
(gdb) disass /r 0x000103e8,+60
Dump of assembler code from 0x103e8 to 0x10424:
   0x000103e8 <main+0>:	28 10 9f e5	ldr	r1, [pc, #40]	; 0x10418 <addr_of_myvar1>
   0x000103ec <main+4>:	03 30 a0 e3	mov	r3, #3
   0x000103f0 <main+8>:	00 30 81 e5	str	r3, [r1]
=> 0x000103f4 <main+12>:	20 20 9f e5	ldr	r2, [pc, #32]	; 0x1041c <addr_of_myvar2>
   0x000103f8 <main+16>:	04 30 a0 e3	mov	r3, #4
   0x000103fc <main+20>:	00 30 82 e5	str	r3, [r2]
   0x00010400 <main+24>:	10 10 9f e5	ldr	r1, [pc, #16]	; 0x10418 <addr_of_myvar1>
   0x00010404 <main+28>:	00 10 91 e5	ldr	r1, [r1]
   0x00010408 <main+32>:	0c 20 9f e5	ldr	r2, [pc, #12]	; 0x1041c <addr_of_myvar2>
   0x0001040c <main+36>:	00 20 92 e5	ldr	r2, [r2]
   0x00010410 <main+40>:	02 00 81 e0	add	r0, r1, r2
   0x00010414 <main+44>:	1e ff 2f e1	bx	lr
   0x00010418 <addr_of_myvar1+0>:	b8 05 02 00			; <UNDEFINED> instruction: 0x000205b8
   0x0001041c <addr_of_myvar2+0>:	bc 05 02 00			; <UNDEFINED> instruction: 0x000205bc
   0x00010420 <__libc_csu_init+0>:	f8 43 2d e9	push	{r3, r4, r5, r6, r7, r8, r9, lr}
End of assembler dump.
(gdb) 

*/

/* 

(gdb) stop display
(gdb) display /r *0x00205bc
3: *0x00205bc = 0
(gdb) display /r *0x00205b8
4: *0x00205b8 = 3
(gdb) si
0x000103fc in main ()
4: *0x00205b8 = 3
3: *0x00205bc = 0
2: 0x00205bc = 132540
1: 0x00205b8 = 132536
(gdb) si
0x00010400 in main ()
4: *0x00205b8 = 3
3: *0x00205bc = 4
2: 0x00205bc = 132540
1: 0x00205b8 = 132536
(gdb) si
0x00010404 in main ()
4: *0x00205b8 = 3
3: *0x00205bc = 4
2: 0x00205bc = 132540
1: 0x00205b8 = 132536
(gdb) 

*/
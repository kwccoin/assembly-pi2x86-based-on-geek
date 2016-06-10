/* -- load01.s */
 
/* -- Data section */
.data
 
/* Ensure variable is 4-byte aligned */
.balign 4
/* Define storage for myvar1 */
myvar1:
    /* Contents of myvar1 is just 4 bytes containing value '3' */
    .word 3
 
/* Ensure variable is 4-byte aligned */
.balign 4
/* Define storage for myvar2 */
myvar2:
    /* Contents of myvar2 is just 4 bytes containing value '4' */
    .word 4
 
/* -- Code section */
.text
 
/* Ensure code is 4 byte aligned */
.balign 4
.global main
main:
    ldr r1, addr_of_myvar1 /* r1 ← &myvar1 */
    ldr r1, [r1]           /* r1 ← *r1 */
    ldr r2, addr_of_myvar2 /* r2 ← &myvar2 */
    ldr r2, [r2]           /* r2 ← *r2 */
    add r0, r1, r2         /* r0 ← r1 + r2 */
    bx lr
 
/* Labels needed to access data */
addr_of_myvar1 : .word myvar1
addr_of_myvar2 : .word myvar2

/*
(gdb) disass 0x000103e8,+40
Dump of assembler code from 0x103e8 to 0x10410:
=> 0x000103e8 <main+0>:	ldr	r1, [pc, #16]	; 0x10400 <addr_of_myvar1>
   0x000103ec <main+4>:	ldr	r1, [r1]
   0x000103f0 <main+8>:	ldr	r2, [pc, #12]	; 0x10404 <addr_of_myvar2>
   0x000103f4 <main+12>:	ldr	r2, [r2]
   0x000103f8 <main+16>:	add	r0, r1, r2
   0x000103fc <main+20>:	bx	lr
   0x00010400 <addr_of_myvar1+0>:	andeq	r0, r2, r0, lsr #11
   0x00010404 <addr_of_myvar2+0>:	andeq	r0, r2, r4, lsr #11
   0x00010408 <__libc_csu_init+0>:	push	{r3, r4, r5, r6, r7, r8, r9, lr}
   0x0001040c <__libc_csu_init+4>:	mov	r7, r0
End of assembler 
*/

/*
(gdb) disass /r 0x000103e8,+40 
Dump of assembler code from 0x103e8 to 0x10410:
=> 0x000103e8 <main+0>:	10 10 9f e5	ldr	r1, [pc, #16]	; 0x10400 <addr_of_myvar1>
   0x000103ec <main+4>:	00 10 91 e5	ldr	r1, [r1]
   0x000103f0 <main+8>:	0c 20 9f e5	ldr	r2, [pc, #12]	; 0x10404 <addr_of_myvar2>
   0x000103f4 <main+12>:	00 20 92 e5	ldr	r2, [r2]
   0x000103f8 <main+16>:	02 00 81 e0	add	r0, r1, r2
   0x000103fc <main+20>:	1e ff 2f e1	bx	lr
   0x00010400 <addr_of_myvar1+0>:	a0 05 02 00	andeq	r0, r2, r0, lsr #11
   0x00010404 <addr_of_myvar2+0>:	a4 05 02 00	andeq	r0, r2, r4, lsr #11
   0x00010408 <__libc_csu_init+0>:	f8 43 2d e9	push	{r3, r4, r5, r6, r7, r8, r9, lr}
   0x0001040c <__libc_csu_init+4>:	00 70 a0 e1	mov	r7, r0
End of assembler dump.
(gdb) 

*/
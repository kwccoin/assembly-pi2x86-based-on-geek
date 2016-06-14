; -----------------------------------------------------------------------------
;
;/* -- first.s */
;/* This is a comment */
;.global main /* 'main' is our entry point and must be global */
;
;main:          /* This is main */
;mov r0, #2 /* Put a 2 inside the register r0 */
;bx lr      /* Return from main */
;
; need one more returns */


;/* -- first.s */
;/* This is a comment */
; under cross x86_64-elf-ld: warning: cannot find entry symbol _start; defaulting to 0000000000400080
; under mac os x need _main 
; /usr/bin/gcc
;gcc  -o first first.o
;Undefined symbols for architecture x86_64:
;  "_main", referenced from:
;     implicit entry/start for main executable
;ld: symbol(s) not found for architecture x86_64
;clang: error: linker command failed with exit code 1 (use -v to see invocation)
;make: *** [first] Error 1

    global _start ;/* 'main' is our entry point and must be global */
    global _main ;/* 'main' is our entry point and must be global */
    section .text

_main:
_start:           ;/* This is main */
    mov rax, 2 ;/* Put a 2 inside the register r0 */
    ret         ;/* Return from main */
;/* need one more returns */

; -----------------------------------------------------------------------------
; A 64-bit function that returns the maximum value of its three 64-bit integer
; arguments.  The function has signature:
;
;   int64_t maxofthree(int64_t x, int64_t y, int64_t z)
;
; Note that the parameters have already been passed in rdi, rsi, and rdx.  We
; just have to return the value in rax.
; -----------------------------------------------------------------------------

;global  _max3
;section .text
;_max3:
;mov     rax, rdi                ; result (rax) initially holds x
;cmp     rax, rsi                ; is x less than y?
;cmovl   rax, rsi                ; if so, set result to y
;cmp     rax, rdx                ; is max(x,y) less than z?
;cmovl   rax, rdx                ; if so, set result to z
;ret                             ; the max will be in rax
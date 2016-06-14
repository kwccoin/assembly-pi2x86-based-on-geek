; ----------------------------------------------------------------------------------------
; Writes "Hello, World" to the console using only system calls. Runs on 64-bit Linux only.
; To assemble and run:
;
;     nasm -felf64 hello.asm && ld hello.o && ./a.out
; ----------------------------------------------------------------------------------------

;        global  start

;        section .text
;start:
;        ; write(1, message, 13)
;        mov     rax, 1                  ; system call 1 is write
;        mov     rdi, 1                  ; file handle 1 is stdout
;        mov     rsi, message            ; address of string to output
;        mov     rdx, 13                 ; number of bytes
;        syscall                         ; invoke operating system to do the write;

;        ; exit(0)
;        mov     eax, 60                 ; system call 60 is exit
;        xor     rdi, rdi                ; exit code 0
;        syscall                         ; invoke operating system to exit
;message:
;        db      "Hello, World", 10      ; note the newline at the end

%define SYSCALL_WRITE 0x2000004
%define SYSCALL_EXIT  0x2000001

global start
start:
  mov rdi, 1
  mov rsi, str
  mov rdx, strlen
  mov rax, SYSCALL_WRITE
  syscall

  mov rax, SYSCALL_EXIT
  mov rdi, 0
  syscall

section .data
str:
  db `Hello, assembly!\n` ; to use escape sequences, use backticks
strlen equ $ - str
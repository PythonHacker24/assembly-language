global _start		; specifying the entry point for the program

section .text		; contains the code to be executed

_start:			; starting point of code execution

	; syscall-write: Printing the hello world

	mov rax, 0x01		; moving 0x01 hex value to the rax register	
	mov rdi, 0x01		; moving 0x01 hex value to the rdi register
	mov rsi, msg		; moving the output variable containing the string to the rdx register
	mov rdx, msglength	; moving length of the string to the rdx register
	syscall			; initiating the system call
	
	; syscall-read: Reading the user input

	mov rax, 0x00			; moving 0x00 hex value to the rax register
	mov rdi, 0x00			; moving 0x00 hex value to the rdi register
	mov rsi, input_buffer		; moving the input_buffer value to rsi
	mov rdx, input_buffer_length	; moving the input_buffer_length value to rdx
	syscall				; initiating the system call

	; syscall-write: Output of the user input value

	mov rax, 0x01
	mov rax, 0x01
	mov rsi, input_buffer
	mov rdx, input_buffer_length
	syscall

	; syscall-exit: returning exit code 0 

	mov rax, 0x3c		; moving the value of 0x3c (decimal: 60) to rax register
	mov rdi, 0x00		; moving the value of 0x00 hex to the rdi register (exit code) 
	syscall 		; initiating system call

section .data		; contains the variables 

	input_buffer: db "test"		; filling the input_buffer with a string
	input_buffer_length: equ 0x20	; setting up the input_buffer_length

	msg: db "Hello World!", 0x0a		; db (define byte) 0x0a hex is decimal 10 (new line)
	msglength: equ $ - msg			; message length 


; ---------------------------------------------------------- ;

; assembling the instructions

; nasm -f elf64 -o hello.o hello.s
; gcc hello.o -o hello -nostdlib
; ./hello

; ---------------------------------------------------------- ;



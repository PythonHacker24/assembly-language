; ---------------------------------------------------------- ;

;	Author: Aditya Patil	
;	Email: adityapatil24680@gmail.com
;	x64 Assembly Language with NASM

; ---------------------------------------------------------- ;

global _start		; specifying the entry point for the program

section .text		; contains the code to be executed

_start:			; starting point of code execution
	
	; syscall-read: Reading the user input

	mov rax, 0x00			; moving 0x00 hex value to the rax register
	mov rdi, 0x00			; moving 0x00 hex value to the rdi register
	mov rsi, input_buffer		; moving the input_buffer value to rsi
	mov rdx, input_buffer_length	; moving the input_buffer_length value to rdx
	syscall				; initiating the system call

	; check for special string that will check if the contol flow has to change

	mov rax, input_buffer
	mov rdx, 0x100
	cmp rax, rdx
	je change_flow			; jmp command changes the control flow and jumps to the change_flow function
	
	; syscall-write: Output of the user input value

	mov rax, 0x01
	mov rdi, 0x01
	mov rsi, input_buffer
	mov rdx, input_buffer_length
	syscall

	; syscall-exit: returning exit code 0 

	mov rax, 0x3c		; moving the value of 0x3c (decimal: 60) to rax register
	mov rdi, 0x00		; moving the value of 0x00 hex to the rdi register (exit code) 
	syscall 		; initiating system call

change_flow:
	
	; syscall-write: Output the special string

	mov rax, 0x01
	mov rdi, 0x01
	mov rsi, change_string
	mov rdx, change_string_length
	syscall

	; syscall-exit: returning exit code 0

	mov rax, 0x3c
	mov rdi, 0x00
	syscall

section .data		; contains the variables 

	input_buffer: db "test"		; filling the input_buffer with a string
	input_buffer_length: equ 0x5	; setting up the input_buffer_length

	change_string: db "Control Flow Changed!", 0x0a		; Output this for control flow change
	change_string_length: equ $ - change_string		; Size of the indicatior 

	special_message: db "assembly"				; special message to be displayed on control flow change

section .bss
	
	input_buffer resq 1		; resrve 64 bits (8 bytes) for user input 

; ------------------------ Notes -------------------------- ;

; assembling the instructions

; nasm -f elf64 -o hello.o hello.s
; gcc hello.o -o hello -nostdlib
; ./hello

; file descriptor for x64 
; stdin:  0
; stdout: 1
; stderr: 2

; call <function_name> will call the function
; xor <register>, <register>
; .bss contains the allocation of space for buffers without allocation
; resq stands for "reserve memory space for a quadword"

; The convention of _function & .function & function [
; It's important to note that these conventions are not universally 
; followed, and they can vary from one assembly language to another. 
; Additionally, some assemblers and toolchains may have specific requirements 
; or defaults for label naming. ]

; .function: a dot prefix may be used to indicate that a label is local or "hidden." 
; _function:  The underscore prefix is often used to indicate that a label is global or external.
; function: This is another way to indicate that a label is global or external.

; ---------------------------------------------------------- ;






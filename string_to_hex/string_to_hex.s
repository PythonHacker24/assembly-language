; ------------------------------------------------- ;

;	Author: Aditya Patil

;       Email: adityapatil24680@gmail.com

;	x64 Assembly Language with NASM

; ------------------------------------------------- ;

global _start

section .data

	hex_chars db "ABCDEF0123456789"			; valid hex characters
	
	success_message: db "Secret Unlocked", 0x0a		; success message
	fail_message: db "Vault Locked", 0x0a			; failed message
	
	success_message_length: equ $ - success_message
	fail_message_length: equ $ - fail_message
	
	error_message: db "invalid hex code", 0x0a
	error_message_size: equ $ - error_message

section .bss

	input_buffer resq 16

section .text

_start:
	
	; --- main code here --- ;

	; getting the user input: syscall-read
	
	mov rax, 0x00		
	mov rdi, 0x00
	mov rsi, input_buffer
	mov rdx, 16
	syscall

	mov rdi, rsi			; hex_to_int takes an value from rdi
	call hex_to_int			; calling the hex to integer
	
	; hex value is in the rax
	
	cmp rax, 0x100			; compare the value in rax with 0x100 hex 
	je success			; jump to success function (exit from there) 

	; program will reach here if number is not 0x100, so throw an failed message

	mov rax, 0x01
	mov rdi, 0x01
	mov rsi, fail_message
	mov rdx, fail_message_length
	syscall
	
	; exiting with code 0
	
	mov rax, 0x3c
	mov rdi, 0x00
	syscall

success:
	
	; success message
	
	mov rax, 0x01
	mov rdi, 0x01
	mov rsi, success_message
	mov rdx, success_message_length
	syscall
		
	; exiting with code 0

	mov rax, 0x3c
	mov rdi, 0x00
	syscall

hex_to_int:
	
	; --- init values --- ;

	xor rax, rax			; clearing the rax (accumulator)
	xor rcx, rcx			; clearing the rcx (loop counter)

convert_loop:
	
	movzx rdi, byte [rdi + rcx]	; get the char from the string
	test rdi, rdi			; check if it is a null ptr (end of the string)
	jz done 			; if yes, jump to done

	; check if the char is a valid hex value
	
	mov rbx, hex_chars		; load the test values to rbx 
	mov rsi, 0			; init rsi = 0

; rdi contains the char
; rbx contains the hex_chars
; rcx is the program counter

search_loop:

	cmp rdi, [rbx + rsi]		; take a single char from the hex_value and compare to the char
	je digit_found			; jump to digit_found function if found

	; not found!

	add rsi, 1			; getting ready for the next test char
	cmp rsi, 16			; check if all hex test cases are completed
	jne search_loop			; jump to check next hex test char if rsi != 16

	; if program reaches this point, then exit with an error (not test cases passed -> invalid hex char)
	
	; printing the invalid message

	mov rax, 0x01
	mov rdi, 0x01
	mov rsi, error_message
	mov rdx, error_message_size
	syscall

	; exit with exit code 0

	mov rax, 0x3c
	mov rdi, 0x00
	syscall 

digit_found:

	imul rdi, rdi, 16		; rax = rax * 16
	add rax, rdi			; building up the hex value

	inc rcx 			; incrementing the program counter
	jmp convert_loop 		; loop back the the convert loop section

done: 
	
	ret
	
; ---------------------------------------- Notes ---------------------------------------- ;
;
; when refering to a pointer holding some value, it's actually the memory address the registers
; are holding with it. 
; Example:
;	rbx = "ABCEDF"
;	rbx is pointing to A
;	rbx + 1 = B
;	
;	hence loop over: rsi = 0 to rsi = 6
;		[ rbx + rsi ] will fetch desired values 
;
; --------------------------------------------------------------------------------------- ;


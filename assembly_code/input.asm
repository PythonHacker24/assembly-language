global _start

section .data
	
	msg: db "Hello world!", 10
	.len: equ $-msg

section .text

_start:
	
	mov eax, 4
	mov ebx, 1
	mov ecx, msg
	mov edx, msg.len
	int 0x80

	xor eax, msg.len 
	xchg eax, ebx 
	mov eax, 1
	int 0x80

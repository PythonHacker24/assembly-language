; since code is data and data is code (which is used in the van newmans architecture) 
; the data of the code and the data that would be there in the code has to be stored in different places 
; this is called as segementation

; db means define byte 
; since ASCII characters are also one byte long, they can also be defined this way
; db 'A'
; db 'ABCD'
; db 'BAN', 'A', '78', '65'

; [variableName] points to the first data of the variable
; the same work of [variableName + 0x7c00] where 0x7c00 is an offset can done with 
; [org 0x7c00]

; [memory_location] in nasm indicates the value stored in the memory location 

[org 0x7c00]

mov ah, 0x0e ; bios function for writing in tty mode 
mov bx, variableName

printString:
  mov al, [bx]
  cmp al, 0 
  je exit 
  int 0x10 
  inc bx 
  jmp printString

; defining a variable or a buffer (buffer with times 10 db 0)
variableName:
  db "This is Aditya's Operating System", 0

; the mbr partition is of 512 bytes which contains the code to boot the Operating System
exit:
  jmp $

times 510-($-$$) db 0 ; filling the rest of the partition memory with 0 
db 0x55, 0xAA         ; the last bytes mush be 0x55 and 0xAA

; keyboard input 
; ah = 0
; Bios interrupt: 0x16
; Result: The system waits for a key press
; al: ASCII character 
; ah: scancode

; Notes:
; ah and al are 8-bit registers 


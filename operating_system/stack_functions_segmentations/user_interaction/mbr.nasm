; Take the user input
; store it in the stack (push the values into the stack)
; after pressing enter key, start fetching values from the stack 
; pop the values and print them on the screen 

; start a prompt 
mov ah, 0x0e
mov bx, prompt 

printPrompt:
  mov al, [bx + 0x7c00] 
  cmp al, 0 
  je getInput
  int 0x10
  inc bx 
  jmp printPrompt

prompt: 
  db "aditya> ", 0

getInput:
  mov ah, 0
  int 0x16
  push ax
  mov ah, 0x0e 
  int 0x10
  cmp al, 0x0D
  je spacePrint
  jmp getInput

spacePrint:
  mov ah, 0x0e
  mov al, 0x0a
  int 0x10
  jmp printInput

printInput:
  pop ax
  mov ah, 0x0e 
  int 0x10
  cmp al, 0x0D 
  je exit
  jmp printInput

exit:
  jmp $

times 510-($-$$) db 0 
db 0x55, 0xAA



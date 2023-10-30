; ask user for input 
; print the input
; the input is a character

; getting an input from the user 
printOutput:
  mov ah, 0 
  int 0x16 
  mov ah, 0x0e
  int 0x10
  cmp al, 0x0D  ; don't take input if enter key is pressed
  je exit
  jmp printOutput

exit:
  jmp $

worddata:
  times 10 db 0

times 510-($-$$) db 0 
db 0x55, 0xAA







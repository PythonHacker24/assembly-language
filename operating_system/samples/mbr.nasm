mov ah, 0x0e
mov al, 'A'
int 0x10

loop:
  mov ah, 0x0e
  inc al
  int 0x10
  cmp al, 'z' + 1
  jne loop

jmp $
times 510-($-$$) db 0
db 0x55, 0xAA

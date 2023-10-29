mov bh, 0

capital:
  inc bh
  mov ah, 0x0e
  add bh, 'A'
  mov al, bh
  int 0x10

  jmp small

small:
  mov ah, 0x0e
  add bh, 'a'
  mov al, bh
  int 0x10

  cmp al, 'z'
  jne capital
  jmp exit

exit:
  jmp $

times 510-($-$$) db 0
db 0x55, 0xAA

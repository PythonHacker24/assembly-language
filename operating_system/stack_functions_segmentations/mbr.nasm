; when we pop a value from the top of a stack, we remove it from the top and assign it to a register
; Example code 
; push 6
; pop ax 
; has the same effect as 
; mov ax, 6

; similar instructions: pusha and popa -> They store and retreat values from the stack in a order
; ax, cx, dx, bx, sp, bp, si, di 
; pushed this way and poped in the reverse way 

; Use case scenario: can store the value of the register for temporary in the stack 
; push ax
; transform:
;   ax, 5
; pop ax 

; Use case scenerio for pusha and popa 
; A program using all these registers and now has got an interrupt 
; in this case, the values in the registers needs to be stored 
; pusha 
; jmp procedure:
;   ....
; popa 

; since we are dealing with 16 bit memory addressing, we have 65535 memry locations 
; this is not too much and hance we need segmentation
; segmentation divides the memory into parts, with maximum as 64KB
; this segmentation can be like: data | code | stack | extra segment 

; Data segment -> contains the data
; Code segment -> contains the code 
; Stack segment -> contains the Stack  




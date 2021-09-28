getkey:                     ; Keep in mind that the [eax] register will lose its data
    mov ah, 0
    int 0x16
    ret    

printchar:
    mov ah, 0x0e
    int 0x10
    ret
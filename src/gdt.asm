gdt_nulldesc:
    dd 0
    dd 0

gdt_codedesc:
    dw 0xffff           ; Limit
    dw 0x0000           ; Base (low)
    db 0x00             ; Base (med)
    db 10011010b        ; Flags
    db 11001111b        ; Flags + Upper Limit
    db 0x00             ; Base (high)

gdt_datadesc:
    dw 0xffff           ; Limit
    dw 0x0000           ; Base (low)
    db 0x00             ; Base (med)
    db 10010010b        ; Flags
    db 11001111b        ; Flags + Upper Limit
    db 0x00             ; Base (high)

gdt_end:

gdt_descriptor:
    gdt_size:
        dw gdt_end - gdt_nulldesc - 1
        dq gdt_nulldesc

codeseg equ gdt_codedesc - gdt_nulldesc
dataseg equ gdt_datadesc - gdt_nulldesc

; For more information about this unintelligble crap, visit https://youtu.be/pXzortxPZR8
; More unintelligble crap follows. For more information about that, visit: https://youtu.be/sk_ngabpwXQ

;----------------------------------------------------------------------------
[BITS 32]

edit_gdt:
    mov [gdt_codedesc + 6], byte 10101111b      ; Make GDT into 64 bit instead of 32 bit (whatever that means)
    mov [gdt_datadesc + 6], byte 10101111b      ; For more information, see the section pretext
    ret

;----------------------------------------------------------------------------
; 32 bit section above (only code for 32 bits works above)
; Back to 16 bits below
[BITS 16]

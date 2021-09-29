page_table_entry equ 0x1000

setup_identity_paging:
    mov edi, page_table_entry               ; Move the starting location of the table to [edi]
    mov cr3, edi                            ; Move [edi] to control register 3
    mov dword [edi], 0x2003                 ; The hex value points to the second table, along with setting some required flags. Don't touch this; it's magic!
    add edi, 0x1000                         ; Add 4096 to the value of the table origin to prepare for the second table
    mov dword [edi], 0x3003                   ; Second table stuff
    add edi, 0x1000
    mov dword [edi], 0x4003
    add edi, 0x1000                         ; Last table is a bit special; its HUGE (512 bytes (maybe))
    mov ebx, 0x00000003                     ; Sets the appropriate flags
    mov ecx, 512

    .set_entry:
        mov dword [edi], ebx
        add ebx, 0x1000
        add edi, 8
        loop .set_entry
    
    ;----------------------
    mov eax, cr4
    or eax, 1 << 5          ; Physical address extension paging requires PAE bit to be set in cr4 (control register 4)
    mov cr4, eax
    ;----------------------
    ; The section above is to activate physical address extension paging
    ; (i dont even know what the hell that is)

    ;----------------------
    mov ecx, 0xc0000080
    rdmsr
    or eax, 1 << 8
    wrmsr
    ;---------------------
    ; The section above was to set the long mode bit in EFER (bruh wtf) model specific register

    ;---------------------
    mov eax, cr0
    or eax, 1 << 31
    mov cr0, eax
    ;---------------------
    ; This section finally enables paging (i dont know what the hell we were doing previously then)

    ret

; More info:
; The video I followed is here: https://youtu.be/sk_ngabpwXQ
; To read more about paging later, visit: https://wiki.osdev.org/Paging

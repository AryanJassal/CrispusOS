[org 0x7e00]

jmp enter_protected_mode

%include 'gdt.asm'
%include 'CPUID.asm'
%include 'simplepaging.asm'

enter_protected_mode:
    call enable_a20             ; Enable the A20 memory lane (for more info, see here: https://wiki.osdev.org/A20_Line)
    cli                         ; Disable BIOS interrupts
    lgdt [gdt_descriptor]
    ;-------------------------------
    mov eax, cr0
    or eax, 1                   ; Set PE (Protected Enable) flag in CR0 (Control Register 0) (2)
    mov cr0, eax
    ;------------------------------
    ; The above section does magic to tell the CPU that we now want to be in 32-bit protected mode
    jmp codeseg:start_protected_mode

enable_a20:
    in al, 0x92
    or al, 2
    out 0x92, al
    ; These three lines are to enable the a20 line. Even I don't know too much about it.
    ; It's supposedly a cheaty/hacky method to do this and won't work on all machines,
    ; But its good enough for now.
    ret

[BITS 32]

start_protected_mode:
    mov ax, dataseg
    mov ds, ax
    mov ss, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov [0xb8000], byte 'Y'

    call detect_CPUID
    call detect_long_mode
    call setup_identity_paging

    jmp $

times 4096-($-$$) db 0

; More info here:
;   1. See bootloader.asm
;   2. https://wiki.osdev.org/Protected_Mode

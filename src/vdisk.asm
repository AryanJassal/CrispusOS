jmp enter_protected_mode

%include 'gdt.asm'
%include 'printf.asm'

enter_protected_mode:
    call enable_a20             ; Enable the A20 memory lane (for more info, see here: https://wiki.osdev.org/A20_Line)
    cli                         ; Disable BIOS interrupts
    lgdt [gdt_descriptor]
    ;-------------------------------
    mov eax, cr0
    or eax, 1                   ; Set PE (Protected Enable) flag in CR0 (Control Register 0) (2)
    mov cr0, eax
    ;-------------------------------
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

%include 'CPUID.asm'            ; Needs to be compiled in 32 bit mode
%include 'simplepaging.asm'     ; Same here as above

start_protected_mode:
    mov ax, dataseg
    mov ds, ax
    mov ss, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov [0xb8000], byte '('
    mov [0xb8002], byte '.'
    mov [0xb8004], byte 'Y'
    mov [0xb8006], byte '.'
    mov [0xb8008], byte ')'
    mov [0xb800a], byte ' '


    call detect_CPUID               ; Detect if we can use CPUID to go into long (64 bit) mode
    call detect_long_mode           ; Detect if the processor supports long mode (64 bit mode)
    call setup_identity_paging      ; Set up paging for proper memory allocation (mandatory)
    call edit_gdt                   ; Prepare the GDT to enter 64 bit mode from 32 bit mode

    jmp codeseg:start_long_mode     ; Jump to start_long_mode label in 64 bit memory space

; Finally! 64 bit OS! Not that it does anything remotely like Windows x64, so stop comparing them.
[BITS 64]
[extern _start]

start_long_mode:
    mov edi, 0xb8000
    mov rax, 0x1f201f201f201f20     ; Some vodoo crap that can only be done in 64 bit mode by using a 64-bit-exclusive register
    mov ecx, 500
    rep stosq                       ; This is some sort of black magic loop that loops. It wasn't explained. At all.
    call _start
    jmp $

times 2048-($-$$) db 0

; More info here:
;   1. See bootloader.asm
;   2. https://wiki.osdev.org/Protected_Mode

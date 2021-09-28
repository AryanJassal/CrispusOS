[org 0x7c00]

mov bp, 0x7c00              ; Move the stack base pointer at the memory address 0x7c00
mov sp, bp                  ; Move the current stack pointer at the baes (stack is empty)

mov [BOOT_DISK], dl

call readdisk

jmp DATA_SPACE

%include 'printf.asm'
%include 'diskread.asm'
%include 'keyboard.asm'

times 510-($-$$) db 0   ; Make the size of the file exactly 512M for the program to be registered as a bootloader
dw 0xaa55               ; The magic flag required for the computer to read this as a valid operating system

; 1. https://tutorialsbynick.com/writing-an-os-baby-steps/
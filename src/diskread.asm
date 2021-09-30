DATA_SPACE equ 0x8000

readdisk:
    mov ah, 0x02            ; Tell the BIOS we'll be reading the disk
    mov bx, DATA_SPACE      ; Put the new data we read from the disk starting from mem location 0x7e00
    mov al, 16              ; Read n number of sectors from disk
    mov dl, [BOOT_DISK]     ; Read from the drive [boot drive]
    mov ch, 0x00            ; Cylinder 0
    mov dh, 0x00            ; Head 0
    mov cl, 0x02            ; Sector 2

    int 0x13                ; Read disk interrupt
    jc diskreadfailed
    ret

diskreadfailed:
    mov si, error_diskreaderror
    call printf

    jmp $

BOOT_DISK db 0

error_diskreaderror db 'Disk read failed!', 13, 10, 0

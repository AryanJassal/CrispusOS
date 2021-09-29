printf:
    pusha                   ; Push the a register onto the stack
    .printloop:
        mov al, [si]        ; Get the value of the si register and put it in the al register 
        cmp al, 0           ; Compare the current character in the al register
        jne .printchar      ; Jump to print a character if the end of string is not yet reached
        popa                ; If the end of string has been reached, pop the value of the a register back from the stack
        ret                 ; Return from where we called the function

    .printchar:
        mov ah, 0x0e        ; Allows 0x10 interrupt to be used to print characters to the screen [prints from al]
        int 0x10            ; Print character in al register
        add si, 1           ; Increment the si register
        jmp .printloop      ; Go back to the start of the loop to print other characters

newline db 13, 10, 0

debug_test_print db 'Hello, world!', 0

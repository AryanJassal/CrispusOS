; To detect if we can use CPUID, we will see if the value in the flags register remains flipped.
; We will first retrieve the value in the [eax] register, then copy it to [ecx] to compare them later.
; Then, we shift the value stored in [eax] and feed it back in the flags register.
; We will re-read the flags register to see if the bit remained the same, or was flipped back to its original form.
; If it is the same as its original form (stored in [ecx]), then the CPU doesn't support CPUID

detect_CPUID:
    pushfd                      ; Push the flags register onto the stack
    pop eax                     ; Pop the value next in stack (value of flag register) in the register [eax]
    mov ecx, eax                ; Copy the value of [eax] to [ecx] for comparison later
    xor ecx, 1 << 21            ; Flip the bit located in the [ecx] register
    push eax                    ; Push [eax] onto the stack
    popfd                       ; Pop it back in the flags register
    pushfd                      ; Push the flags register onto the stack
    pop eax                     ; Pop it back in the [eax] register
    push ecx                    ; Push the value of [ecx] (original value) onto the stack
    popfd                       ; Pop it back into the flags register (make the flags value return to the original value)
    xor eax, ecx                ; Check if both the bits are the same
    jz no_CPUID                 ; If yes, then CPUID is not supported; jump to appropriate label
    ret

detect_long_mode:
    mov eax, 0x80000001
    cpuid
    test edx, 1 << 29           ; Test if LM-bit (Long Mode bit) (which is bit 29) is set in the [edx] register.
    jz no_long_mode             ; Otherwise, no long mode is available for that CPU
    ret

no_long_mode:
    hlt
    jmp $           ; Just in case

no_CPUID:
    hlt
    jmp $           ; Just in case

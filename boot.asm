; boot.asm - Boot sector (512 bytes)
; Assemble: nasm -f bin boot.asm -o boot.bin

org 0x7c00

start:
    cli                 ; Disable interrupts
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7c00
    sti                 ; Enable interrupts

    ; Load kernel (1 sector at 0x1000)
    mov ah, 0x02
    mov al, 1           ; 1 sector
    mov ch, 0
    mov cl, 2           ; sector 2 (after boot)
    mov dh, 0
    mov dl, 0x00        ; floppy 0
    mov bx, 0x1000      ; load address
    int 0x13

    ; Jump to kernel
    jmp 0x1000

; Boot signature
times 510-($-$$) db 0
dw 0xaa55

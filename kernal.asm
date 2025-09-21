; kernel.asm - Initialize system and run main loop
; Assemble: nasm -f bin kernel.asm -o kernel.bin

org 0x1000

start:
    cli
    ; Set text mode
    mov ah, 0x00
    mov al, 0x03
    int 0x10
    sti

    ; Initialize game
    call init_tetris

main_loop:
    call tetris_loop
    jmp main_loop

; Include Tetris logic
extern init_tetris
extern tetris_loop

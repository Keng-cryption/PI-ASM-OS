; tetris.asm - Minimal Tetris routines
; Assemble: nasm -f elf tetris.asm

global init_tetris
global tetris_loop

section .bss
board resb 200       ; 10x20 game board

section .text

init_tetris:
    ; Clear board
    mov cx, 200
    mov di, board
    mov al, 0
.clear_loop:
    mov [di], al
    inc di
    loop .clear_loop
    ret

tetris_loop:
    ; TODO: implement falling pieces, collision, input
    ret

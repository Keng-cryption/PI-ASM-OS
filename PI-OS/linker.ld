ENTRY(_start)

SECTIONS
{
  . = 0x80000;         /* GPU loads kernel8 at 0x80000 on Pi; QEMU matches this */
  .text : {
    KEEP(*(.text._start))
    *(.text*)
  }
  .rodata : { *(.rodata*) }
  .data :   { *(.data*) }
  .bss  :   { *(.bss*) *(COMMON) }
}

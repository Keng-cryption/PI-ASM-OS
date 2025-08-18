  .section .text._start
  .globl _start
_start:
  /* turn off interrupts */
  msr DAIFSet, #0xf

  /* if at EL2, drop to EL1h */
  mrs x0, CurrentEL
  lsrs x0, x0, #2        // EL number in bits [3:2]
  cmp x0, #2             // EL2?
  b.ne 1f
  /* set up HCR_EL2 to enable EL1 AArch64 */
  mov x0, #(1<<31)       // RW=1 (EL1 is AArch64)
  msr HCR_EL2, x0
  /* set EL1 SPSR and return address */
  adr x0, 1f
  msr ELR_EL2, x0
  mov x0, #0x3c5         // SPSR for EL1h, interrupts masked initially
  msr SPSR_EL2, x0
  eret

1:
  /* set up a simple stack */
  ldr x0, =_stack_top
  mov sp, x0

  /* zero .bss */
  ldr x1, =__bss_start
  ldr x2, =__bss_end
2:
  cmp x1, x2
  b.hs 3f
  str xzr, [x1], #8
  b 2b
3:
  bl kernel_main

hang:
  wfe
  b hang

  .align 11
  .global _stack_top
_stack_top:
  .space 4096             /* 4 KiB stack */

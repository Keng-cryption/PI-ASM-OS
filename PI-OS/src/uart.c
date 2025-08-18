#include <stdint.h>
#include "uart.h"

#ifndef PERIPH_BASE
#define PERIPH_BASE 0x3F000000UL
#endif

#define UART0_BASE (PERIPH_BASE + 0x201000)
#define UART_DR    (*(volatile uint32_t *)(UART0_BASE + 0x00))
#define UART_FR    (*(volatile uint32_t *)(UART0_BASE + 0x18))
#define UART_IBRD  (*(volatile uint32_t *)(UART0_BASE + 0x24))
#define UART_FBRD  (*(volatile uint32_t *)(UART0_BASE + 0x28))
#define UART_LCRH  (*(volatile uint32_t *)(UART0_BASE + 0x2C))
#define UART_CR    (*(volatile uint32_t *)(UART0_BASE + 0x30))
#define UART_ICR   (*(volatile uint32_t *)(UART0_BASE + 0x44))

static inline void mmio_write(volatile uint32_t *addr, uint32_t val) { *addr = val; }
static inline uint32_t mmio_read(volatile uint32_t *addr) { return *addr; }

void uart_init(void) {

    mmio_write(&UART_CR, 0x0);


    mmio_write(&UART_ICR, 0x7FF);

    mmio_write(&UART_IBRD, 26);
    mmio_write(&UART_FBRD, 3);

    mmio_write(&UART_LCRH, (1<<4) | (3<<5));

    mmio_write(&UART_CR, (1<<0) | (1<<8) | (1<<9));
}

void uart_putc(char c) {
    while (mmio_read(&UART_FR) & (1<<5)) { }
    mmio_write(&UART_DR, (uint32_t)c);
}

void uart_puts(const char *s) {
    while (*s) {
        if (*s == '\n') uart_putc('\r');
        uart_putc(*s++);
    }
}

#include <stdint.h>
#include "uart.h"

void kernel_main(void) {
    uart_init();
    uart_puts("\n\npi-os: hello from EL1\n");
    for (uint64_t i = 0;; ++i) {
        if ((i & 0x3FFFFF) == 0) {
            uart_puts("still alive...\n");
        }
    }
}

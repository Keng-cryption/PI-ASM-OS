#include <stdint.h>
#include "uart.h"
#include "calc.h"

void kernel_main(void) {
    uart_init();
    uart_puts("\n\npi-os: hello from EL1\n");

    int result = calc(12, 4, '*');  // 12 * 4 = 48

    uart_puts("calc result: ");
    uart_print_int(result);  // You'll need this function if it doesn't exist yet
    uart_puts("\n");

    for (uint64_t i = 0;; ++i) {
        if ((i & 0x3FFFFF) == 0) {
            uart_puts("still alive...\n");
        }
    }
}

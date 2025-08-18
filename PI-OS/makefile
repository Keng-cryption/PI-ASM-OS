CROSS ?= aarch64-elf
CC     = $(CROSS)-gcc
LD     = $(CROSS)-ld
OBJCOPY= $(CROSS)-objcopy

CFLAGS = -O2 -ffreestanding -nostdlib -nostartfiles -Wall -Wextra -mcpu=cortex-a53 -fno-asynchronous-unwind-tables -fno-stack-protector
LDFLAGS= -T linker.ld -nostdlib

SRC = src/start.S src/uart.c src/main.c
OBJ = $(SRC:.c=.o)
OBJ := $(OBJ:.S=.o)

all: kernel8.img

kernel8.elf: $(OBJ) linker.ld
	$(CC) $(LDFLAGS) -o $@ $(OBJ)

kernel8.img: kernel8.elf
	$(OBJCOPY) -O binary $< $@

run: kernel8.img
	qemu-system-aarch64 -M raspi3 -cpu cortex-a53 -kernel kernel8.img -serial stdio -nographic

clean:
	rm -f $(OBJ) kernel8.elf kernel8.img

.PHONY: all run clean

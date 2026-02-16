CC = arm-none-eabi-gcc
AS = arm-none-eabi-gcc
OBJCOPY = arm-none-eabi-objcopy

OBJDIR = build

# Match Debug configuration flags (see nbproject/Makefile-Debug.mk)
CFLAGS_BASE = -Wall -Wno-write-strings -Wno-char-subscripts -fno-stack-protector \
	-DMALLOC_PROVIDED -mcpu=arm926ej-s -O3 -mfloat-abi=soft
ASFLAGS = -x assembler-with-cpp -c -O0 -mcpu=arm926ej-s -mthumb -Wall -fmessage-length=0
LDFLAGS = -T ./src/fnirsi_1013d.ld -nostdlib -lc -lgcc

CFLAGS = $(CFLAGS_BASE) -I include

.PHONY: all image clean

SRCS_C = \
	src/DS3231.c \
	src/PC_interface.c \
	src/ccu_control.c \
	src/cdc_class.c \
	src/diskio.c \
	src/display_control.c \
	src/display_lib.c \
	src/ff.c \
	src/ffunicode.c \
	src/fnirsi_1013d_scope.c \
	src/font_0.c \
	src/font_2.c \
	src/font_3.c \
	src/font_4.c \
	src/font_5.c \
	src/fpga_control.c \
	src/generator.c \
	src/icons.c \
	src/interrupt.c \
	src/mass_storage_class.c \
	src/menu.c \
	src/power_and_battery.c \
	src/ref_and_math.c \
	src/scope_functions.c \
	src/sd_card_interface.c \
	src/sin_cos_math.c \
	src/spi_control.c \
	src/statemachine.c \
	src/test.c \
	src/timer.c \
	src/touchpanel.c \
	src/usb_interface.c \
	src/variables.c \
	src/syscalls.c

SRCS_S = \
	asm/memcmp.s \
	asm/memcpy.s \
	asm/memmove.s \
	asm/memset.s \
	asm/start.s

OBJS = \
	$(patsubst src/%.c,$(OBJDIR)/%.o,$(SRCS_C)) \
	$(patsubst asm/%.s,$(OBJDIR)/%.o,$(SRCS_S))

all: image

image: $(OBJDIR)/fnirsi_1013d_scope.bin

$(OBJDIR)/fnirsi_1013d_scope.elf: $(OBJS)
	@mkdir -p $(OBJDIR)
	$(CC) -o $@ $(OBJS) $(LDFLAGS)

$(OBJDIR)/fnirsi_1013d_scope.bin: $(OBJDIR)/fnirsi_1013d_scope.elf
	$(OBJCOPY) -O binary $< $@
	./util/mksunxi $(OBJDIR)/fnirsi_1013d_scope.bin

$(OBJDIR)/%.o: src/%.c
	@mkdir -p $(OBJDIR)
	$(CC) $(CFLAGS) -c -o $@ $<

$(OBJDIR)/%.o: asm/%.s
	@mkdir -p $(OBJDIR)
	$(AS) $(ASFLAGS) -o $@ $<

clean:
	@echo "Cleaning build artifacts..."
	rm -rf $(OBJDIR)

fel:
	@echo "Building and booting through FEL..."
	$(MAKE) all
	sudo ./util/sunxi-fel -p write 0x7FFFFFE0 $(OBJDIR)/fnirsi_1013d_scope.bin exe 0x80000000


	
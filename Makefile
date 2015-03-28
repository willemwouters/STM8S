SDCC=sdcc
SDLD=sdld
OBJECTS=blinky.ihx uart.ihx
OBJECT=blinky

.PHONY: all clean flash

all: $(OBJECTS)

clean:
	rm -f $(OBJECTS)
	rm *.lst *.rel *.map
	rm *.rst *.lk *.sym
	rm *.asm

flash: $(OBJECT).ihx
	stm8flash -cstlink -pstm8l150 -w $(OBJECT).ihx

%.ihx: %.c
	$(SDCC) -lstm8 -mstm8 --out-fmt-ihx $(CFLAGS) $(LDFLAGS) $<

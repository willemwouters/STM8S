SDCC=sdcc
SDLD=sdld

SRC=$(wildcard *.c)
SRC:=$(wildcard periph/src/*.c)

OBJECT=uart
OBJS=$(SRC:.c=.o)

CFLAGS=-I periph/inc -DSTM8S103

.PHONY: all clean flash

all: $(OBJS)

clean:
	rm -f $(OBJS)
	rm *.lst *.rel *.map
	rm *.rst *.lk *.sym
	rm *.asm *.o *.ihx
	

bin: $(OBJECT).bin
	stm8flash -cstlinkv2  -pstm8s103 -s eeprom -w $(OBJECT).bin 

flash: $(OBJECT).ihx
	stm8flash -cstlinkv2  -pstm8s103 -w $(OBJECT).ihx 

%.bin: %.ihx
	objcopy -Iihex -Obinary $(OBJECT).ihx $(OBJECT).bin

%.ihx: %.o
	echo "test"
	
%.o: %.c
	$(SDCC) -lstm8 -mstm8 $(CFLAGS) $(LDFLAGS) -c $< -o $@
	#$(SDCC) -lstm8 -mstm8 $(CFLAGS) $(LDFLAGS) $<

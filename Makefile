all: blink lcd

blink: blink.bin
lcd: lcd.bin
serial_echo: serial_echo.bin

# write: lcd.write
write: serial_echo.write
# write: blink.write

%.bin: %.o be6502rom.cfg
	cl65 --no-target-lib -o $@ -m $*.map -C be6502rom.cfg $<

%.write: %.bin
	minipro --device AT28C256 --unprotect --protect --write $<

%.o: %.s
	ca65 -o $@ -l $*.list $<

%.s: %.c
	cc65 -o $@ $<

clean:
	-rm *.o *.bin *.map *.list

hello.bin: hello.o
	cl65 -t be6502 -l hello.asm -m hello.map -o $@ $<

# Disable build-in rules
.SUFFIXES:

.PHONY: write

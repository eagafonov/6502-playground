all: blink lcd

blink: blink.bin
lcd: lcd.bin

write: lcd.write
# write: blink.write

%.bin: %.o be6502rom.cfg
	cl65 --no-target-lib -o $@ -C be6502rom.cfg $<

%.write: %.bin
	minipro -p AT28C256 --write $<

%.o: %.s
	ca65 -o $@ $<

clean:
	-rm *.o *.bin

# Disable build-in rules
.SUFFIXES:

.PHONY: write

all: blink lcd

blink: blink.bin
lcd: lcd.bin

write: lcd.write
# write: blink.write

%.bin: %.o be6502rom.cfg
	cl65 --no-target-lib -o $@ -m $*.map -C be6502rom.cfg $<

%.write: %.bin
	minipro --device AT28C256 --unprotect --protect --write $<

%.o: %.s
	ca65 -o $@ -l $*.list $<

clean:
	-rm *.o *.bin *.map *.list

# Disable build-in rules
.SUFFIXES:

.PHONY: write

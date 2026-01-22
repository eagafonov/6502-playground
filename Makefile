all: blink lcd

blink: blink.bin
lcd: lcd.bin

write: lcd.write
# write: blink.write

%.bin: %.o eater.cfg
	cl65 -o $@ -C eater.cfg $<

%.write: %.bin
	minipro -p AT28C256 --write $<

%.o: %.s
	ca65 -o $@ $<

clean:
	-rm *.o *.bin

# Disable build-in rules
.SUFFIXES:

.PHONY: write

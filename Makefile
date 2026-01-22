all: blink lcd

blink: blink.bin
lcd: lcd.bin

%.bin: %.o eater.cfg
	cl65 -o $@ -C eater.cfg $<

%.o: %.s
	ca65 -o $@ $<

clean:
	-rm *.o *.bin

# Disable build-in rules
.SUFFIXES:

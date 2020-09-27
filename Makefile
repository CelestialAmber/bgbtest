.PHONY: all tools compare clean tidy

.SUFFIXES:
.SECONDEXPANSION:
.PRECIOUS:
.SECONDARY:

ROM := bgbtest.gb
OBJS := main.o wram.o


### Build tools

ifeq (,$(shell which sha1sum))
SHA1 := shasum
else
SHA1 := sha1sum
endif



all: $(ROM)

compare: $(ROM)
	@$(SHA1) -c rom.sha1

tidy:
	rm -f $(ROM) $(OBJS) $(ROM:.gb=.sym) $(ROM:.gb=.map)
	$(MAKE) -C tools clean

clean: tidy
	find . \( -iname '*.1bpp' -o -iname '*.2bpp' -o -iname '*.pcm' \) -exec rm {} +

tools:
	$(MAKE) -C tools/

ifeq (,$(filter clean tools,$(MAKECMDGOALS)))
$(info $(shell $(MAKE) -C tools))
endif


%.o: dep = $(shell tools/scan_includes $(@D)/$*.asm)
%.o: %.asm $$(dep)
	rgbasm -o $@ -p 0xFF $<

$(ROM): $(OBJS)
	rgblink -n $(ROM:.gb=.sym) -m $(ROM:.gb=.map) -o $@ $(OBJS)
	rgbfix -v -p 0xFF -t "BGBWELCOME" $@

%.2bpp: %.png
	rgbgfx -o $@ $<

%.1bpp: %.png
	rgbgfx -d1 -o $@ $<
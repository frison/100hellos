PREFIX ?= /usr/local

.PHONY: install

# This is the only necessary target in the Makefile
# and it's expected to place the language interpretter 
# or compiler in the path.
install:
	git clone https://github.com/emojicode/emojicode
	cd emojicode && mkdir build
	cd emojicode/build && cmake .. -GNinja
	cd emojicode/build && ninja
	sudo mv emojicode/build/Compiler/emojicodec /usr/local/bin


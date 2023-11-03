PREFIX ?= /usr/local
SRC = unl.c
CFLAGS = -std=c99 -Wall -pedantic
BIN = unl

.PHONY: clean uninstall

$(BIN):
	$(CC) $(SRC) $(CFLAGS) -o $@

# This is the only necessary target in the Makefile
# and it's expected to place the language interpretter
# or compiler in the path.
install: $(BIN)
	install $(BIN) $(PREFIX)/bin

clean:
	rm -f $(BIN)

uninstall:
	rm -f $(PREFIX)/bin/$(BIN)

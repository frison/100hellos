PREFIX ?= /usr/local
SRC = lang.c
CFLAGS = -std=c99 -Wall -pedantic
BIN = lang

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

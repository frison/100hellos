PREFIX ?= /usr/local

.PHONY: install

# This is the only necessary target in the Makefile
# and it's expected to place the language interpretter
# or compiler in the path.
install:
	curl -o mono-4.2.4.4.tar.bz2 -L https://download.mono-project.com/sources/mono/mono-4.2.4.4.tar.bz2
	sudo apk add --no-cache bash gcc g++ make automake autoconf libtool pkgconfig glib-dev gettext-dev
	tar -xjf mono-4.2.4.4.tar.bz2
	git clone --depth=1 https://github.com/boo-lang/boo
	cd mono-4.2.4.4 && 	CFLAGS="$CFLAGS -O2 -flto=auto -DSGEN_WITHOUT_MONO" \
	CXXFLAGS="$CXXFLAGS -O2 -flto=auto" \
	./configure \
		--build=$CBUILD \
		--host=$CHOST \
		--prefix=/usr \
		--sysconfdir=/etc \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--localstatedir=/var \
		--disable-boehm \
		--enable-ninja \
		--disable-rpath \
		--disable-static \
		--enable-parallel-mark \
		--with-mcs-docs=no \
		--without-sigaltstack

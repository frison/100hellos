#!/usr/bin/env sh

cd /artifacts

cd mono-4.2.4 && CFLAGS="$CFLAGS -O2 -flto=auto" \
CXXFLAGS="$CXXFLAGS -O2 -flto=auto" \
./configure \
    --build=$CBUILD \
    --host=$CHOST \
    --prefix=/usr/local \
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

sudo apk add patch
patch -p0 -l < /hello-world/mini_main.patch
patch -p0 -l < /hello-world/sysmacros.patch

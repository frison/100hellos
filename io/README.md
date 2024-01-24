# Io

As a part of the journey of progressing through Seven Languages in Seven Weeks, meet Io -- the Ferris Bueller of programming languages. One of the boons of Io is it's rich concurrency model -- however because this is an alpine based image (which uses musl) and there are some core assumptions in Io around using glibc (in particular, `ucontext.h`) -- Io has to run with `gcompat` to provide a glibc compatibility layer and is installed from the provided debian package instead of building from source.


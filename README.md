# 100 Hellos

This is a repository demonstrating some patterns from [_slash](https://github.com/frison/_slash) showing how 100 different (potential) development environments (along with any necessary compilation steps) can be built, tested, distributed, and ran.

# How this works

The **base containers** are all built first (they're the directories that start with numbers). They are built in **lexical ordering** so are left-padded (lexical sorting of `1`, `10`, and `2` is what lexically?). This allows overlapping language dependencies to be shared via base images (for example, Java 11 dependent languages).

When you use `make [lang]` it will build that language specific container (after building the base containers). You can interact with this container with either `make [lang] INTERACTIVE=1` or `make [lang] && docker run -it 100hellos/[lang]:local`. If you do either of those a good place to start exploring is `cat /entrypoint.sh`.

If you want to jump straight to seeing a `Hello World!` you can use `make [lang] RUN=1` or `docker run 100hellos/[lang]:local`.

# Building and/or running a Hello World!

`make [lang] RUN=1`

**Pro-tip: `R=1` is a shortcut for `RUN=1`**

# Exploring the development environment!

`make [lang] INTERACTIVE=1`

**Pro-tip: `I=1` is a shortcut for `INTERACTIVE=1`**

# What about for the base containers?

You can do the above!


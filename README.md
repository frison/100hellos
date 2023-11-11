# 100 Hellos

This demonstrates "Hello World" in 100 languages (one day...) and their corresponding build/runtime environments. It's a fun way to explore different languages. You can checkout the prebuilt images on [Docker Hub](https://hub.docker.com/r/100hellos).

# How this works

## Prerequisites
- Docker (versions unclear, works with 20.10.18)
- Make (versions unclear, works with GNU Make 4.3)

## Try it out
```
git clone git@github.com:frison/100hellos.git
cd 100hellos
make perl R=1
```

# Building and/or running a Hello World!

**Note:** `[lang]` is a placeholder for the language you want to use.


`make [lang] RUN=1`

**Pro-tip: `R=1` is a shortcut for `RUN=1`**

# Modify a Hello World!

## Option 1: Change the files, and rebuild

- Modify the files in the language directory (e.g. `perl/files`)
- `make [lang] R=1`

## Option 2: Run the container and modify it
- `make [lang] I=1`
- **Now you're inside the container**
  - Head on over to `/hello-world`, `vim` is available

## Option 3: Mount the files into the container
⚠️ This is a bit more advanced, but it's a good way to work with the files in your IDE of choice. **Expect permission issues.**
- Modify your files on disk, as you normally would
- `make [lang] I=1 M=1`
- Execute the appropriate command to run your code
- Modify your files on disk, as you normally would
- Execute the appropriate command to run your code
- **Note how you don't need to rebuild the container between changes**


**Pro-tip: `I=1` is a shortcut for `INTERACTIVE=1`**

# What about adding a new language?

`make new LANG=[lang]`

This will create a new directory, Dockerfile, and outline for your language. You can then tweak and explore it with the `make [lang]` commands above.

## Key Publishing Magic
- It will automatically be published to [DockerHub](https://hub.docker.com/u/100hellos)
- DockerHub's documentation for this image will be automaticall generated, but extended if a `README.md` is present. For example, [Brainfuck](https://hub.docker.com/r/100hellos/brainfuck) does this
- It will be built and tested prior to merging to `main` via github actions.
- It will only do what is necessary.

**Please help contribute, 100 languages is a lot!**

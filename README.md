# 100 Hello Worlds!

<p align="center">
<a href="https://hub.docker.com/r/100hellos" alt="DockerHub!">
    <img src="https://img.shields.io/badge/Hello%20World!-28_to_go-yellow"
        height="130"></a>
</p>

This demonstrates "Hello World" in 100 languages (one day...) and their corresponding build/runtime environments. It's a fun way to explore different languages. You can checkout the prebuilt images on [Docker Hub](https://hub.docker.com/r/100hellos).

# How this works

## Prerequisites
- Docker (versions unclear, works with 20.10.18)
- Make (versions unclear, works with GNU Make 4.3)

## Try it out (from the repository)

⚠️Running the shell commands below should only be done for trusted sources.
```bash
git clone git@github.com:frison/100hellos.git
cd 100hellos
# cat for the cool factor
cat perl/files/hello-world.pl
make perl R=1
```
## Try it out (from DockerHub)

```bash
# Hello World! From perl.
docker run --rm 100hellos/perl:latest

# Or for an interactive shell
docker run --rm -it 100hellos/perl:latest zsh
```

# How to use this repository
## `make [lang] RUN=1`

**Pro-tip: `R=1` is a shortcut for `RUN=1`**

This will build and run the language container locally. Any changes to the files will require a rebuild by running this command.

## `make [lang] INTERACTIVE=1`

**Pro-tip: `I=1` is a shortcut for `INTERACTIVE=1`**

This will build and run the language container locally, and open an interactive shell into it. Any chances made while inside the container will be lost when the container is stopped.

## Modify a Hello World!

### Option 1: Change the files, and rebuild

- Modify the files in the language directory (e.g. `perl/files`)
- `make perl R=1`

### Option 2: Run the container and modify it
- `make perl I=1`
- **Now you're inside the container**
  - Head on over to `/hello-world`, `vim` is available

### Option 3: Mount the files into the container
⚠️ This is a bit more advanced, but it's a good way to work with the files in your IDE of choice. **Expect permission issues.**
- Modify your files on disk, as you normally would
- `make [lang] I=1 M=1`
- Execute the appropriate command to run your code
- Modify your files on disk, as you normally would
- Execute the appropriate command to run your code (it's a loop!)
- **Note how you don't need to rebuild the container between changes**


# What about adding a new language?

`make new HELLO=[lang]`

This will create a new directory, Dockerfile, and outline for your language. You can then tweak and explore it with the `make [lang]` commands above. Check out the [DEVELOPERS.md](./DEVELOPERS.md) for more information on contributing.


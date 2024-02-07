# Hello World! I'm a part of every language!

This is the alpine base image for all of the language images. You can **[check it out on Github here](https://github.com/frison/100hellos/tree/main/.base)**! Multiple versions of alpine are supported, as some languages (👀 at you emojicode) require older versions of alpine.

## Base Container

This container serves as the base for all of the language containers. If you can do it in this container, you can do it in all of the language containers!

## Extension Mounts

|Mount Point|Feature|Usage|
|-|-|-|
|`/home/human/.zshrc.local`| Shell customizations | Sourced on login |
|`/home/human/.zshrc.env`| Mounted environment variables | Sourced on login |
|`/home/human/.zshrc.prompt`| Prompt customizations applied after oh-my-zsh loads | Sourced on login |
|`/home/human/.vimrc.local`| Vim Customizations | Sourced on login |

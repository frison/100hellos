**Modifying the base image will require you to rebuild all language images, this will mean building 100+ images.**

### `git-layer`

This repository makes use of git-layers, which is an alternative to git submodules that fits this repository's needs better. To update and embed external changes into this repository using git-layer:

- Get https://github.com/frison/git-layer
- run `git-layer --apply`

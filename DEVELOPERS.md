# For Developers

PRs are welcome 🥳.

## Porcelain

This is how you interact with the repository's local operations. For example, building and running containers.

This is all done though  `make`, and the [Makefile](./Makefile), and the  [Makefile.language-container.mk](./Makefile.language-container.mk) make this all go.

This works via: `make [folder]`, and can be enriched with parameters:

|Option|Short|Meaning|
|-|-|-|
|`INTERACTIVE`|`I`|Open an interactive terminal into the language container|
|`RUN`|`R`|Build (if necessary) and run the hello-world application|
|`MOUNT`|`M`|Mount your local files into the container <br/>**Use in conjunction with the above parameters.**|

For example:
```bash
make perl R=1
make perl R=1 M=1
make perl INTERACTIVE=1
make perl INTERACTIVE=1 MOUNT=1
make perl I=1
```


## `make new HELLO=[lang]`

This is how you bootstrap a new language. Behind the scenes? It's a `cp -r .template [lang]`, a copy of the [template](./.template) directory.

The newly created files will be visible with a `git status` or equivalent, and will need to be committed when you're done. The materialized template should have enough to get you started.

# The Magic Stuff

The Magic Stuff, is all the CI/CD and automation that makes this project extend beyond the repository. A rough overview:

- Publishes to [DockerHub](https://hub.docker.com/u/100hellos)!
  - Each directory is published, except the ones in [.no-publish](./.no-publish)
  - Only publishes what's [necessary!](./.github/workflows/on-push.yml)
  - [DockerHub image overview generation!](./.github/bin/generate-overview-readme.sh)
  - There are **weekly** [builds](./.github/workflows/weekly-release.yml) for all language containers

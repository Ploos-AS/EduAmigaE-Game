# Student OCI

EduAmigaE-Game must provide a self-contained public student environment.

## Requirements

- no dependency on private Ploos infrastructure
- reproducible build
- public base image and public dependencies
- Amiga E compiler/toolchain required by the course
- build tools required by examples and exercises
- scripts for compiling course projects
- documented emulator integration
- suitable for CI as well as interactive student use

## Base image

Use a minimal Debian base unless a concrete technical reason justifies another choice. The goal is predictable compatibility with the Amiga toolchain rather than minimum image size.

## Planned commands

The final image should make the common path obvious, for example:

```sh
amigae-build examples/pong
amigae-test examples/pong
```

Names are placeholders until the toolchain is implemented.

## M1 acceptance criteria

- image builds from this repository
- compiler invocation is pinned/documented
- at least one course example builds inside the image
- CI can run the same build without private credentials

# Runtime qualification

## Q1 — filesystem/configuration

Status: implemented for test.

The reference runner generates an A500 FS-UAE configuration with:

- user-supplied Kickstart;
- user-supplied bootable Amiga system directory;
- 512 KiB Chip RAM + 512 KiB Slow RAM;
- host-backed source, output, runtime and E-VO directories.

This matches the course's A500/OCS/68000/1 MiB baseline.

## Q2 — unattended boot

Status: not yet qualified.

Required evidence:

1. selected FS-UAE version boots the supplied test system;
2. host-backed directories receive stable Amiga volume/device names;
3. Startup-Sequence or equivalent invokes the course build script;
4. E-VO returns a meaningful process status;
5. emulator terminates or signals completion deterministically.

## Q3 — compiler

Status: pending Q2.

Required evidence:

- compile `examples/hello-game-loop/hello.e`;
- resulting file is an Amiga Hunk executable;
- execute it under the A500 profile;
- no 68020+ requirement is introduced.

A runtime is not called qualified until these steps have been observed, rather than inferred from configuration syntax.

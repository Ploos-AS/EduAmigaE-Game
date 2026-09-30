# Build architecture

E-VO is an Amiga executable, not a native Linux cross-compiler. Upstream builds it as an Amiga Hunk executable.

## Two-layer student environment

The Debian host OCI handles reproducible downloads, checksums, staging and orchestration. An Amiga runtime executes E-VO and qualifies the produced program.

## Verified E-VO layout

For E-VO 3.9.4 the upstream installation model is:

- compiler: `Bin/EVO`
- modules: `Modules/`
- add `Bin` to the AmigaDOS `Path`
- assign `EMODULES:` to `Modules/`

The compiler is invoked as `EVO source.e` and writes an executable using the source basename.

The course runner mirrors that layout directly instead of running the interactive installer.

## Build contract

Host staging:

```text
build/src
build/out
```

Amiga assigns:

```text
EDUSRC:    staged source
EDUOUT:    resulting executables and status markers
EMODULES:  E-VO Modules/
```

The Amiga-side script changes to `EDUSRC:`, invokes E-VO, verifies that the expected executable exists, and copies it to `EDUOUT:`.

## Runtime policy

Initial qualification target:

- A500-class machine
- Motorola 68000
- OCS
- PAL
- 1 MiB practical baseline

The project never redistributes Kickstart or AmigaOS. Students provide legally obtained system files where required.

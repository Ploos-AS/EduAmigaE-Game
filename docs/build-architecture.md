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

The host writes both `BUILD.SOURCE` and `BUILD.OUTPUT`. The Amiga-side script receives both names explicitly, changes to `EDUSRC:`, invokes E-VO, verifies that the expected executable exists, and copies it to `EDUOUT:`. Output-name derivation is intentionally kept out of AmigaDOS.

## Build OS versus target OS

The compiler runtime and the game target are deliberately separate contracts.

Q2/Q3 uses AmigaOS 2.04 or newer as the reference **build OS**. This gives the unattended runner the modern AmigaDOS command syntax used by the E-VO 3.9.4 CLI and keeps the build harness small and deterministic. This does not raise the generated game's CPU or chipset baseline.

The produced executable is qualified separately as a **target runtime** artifact. The course has two primary game profiles: A500/68000/OCS/PAL with AmigaOS-Kickstart 1.x, and A1200/68020/AGA/PAL with AmigaOS-Kickstart 3.x. A500/1.x is the minimum compatibility gate for foundational material. A1200/3.x is the explicit advanced profile; using it must never silently raise the A500 baseline.

## Runtime policy

Primary target qualification:

- A500: 68000, OCS, PAL, AmigaOS/Kickstart 1.x, practical 1 MiB baseline
- A1200: 68020, AGA, PAL, AmigaOS/Kickstart 3.x

The project never redistributes Kickstart or AmigaOS. Students provide legally obtained system files where required.

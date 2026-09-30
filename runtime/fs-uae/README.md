# FS-UAE student runner

This is the first reference implementation of the Amiga build-runner contract.

## Principle

The repository supplies configuration and scripts only.

It does **not** supply:

- Kickstart ROM images;
- Workbench/AmigaOS disks or files;
- other copyrighted Commodore/Amiga system material.

Students point the runner at their own legally obtained files.

## Baseline profile

- A500
- 68000
- OCS
- PAL
- 1 MiB practical course target

Two host directories are exposed to the Amiga:

- `build/src` -> source staging
- `build/out` -> build output

E-VO is installed/staged separately as described by the course toolchain setup.

## Contract

The host invokes `runtime/fs-uae/run-build.sh SOURCE.e`.

The runtime must arrange for the Amiga side to execute:

```text
execute EDU:runtime/build.evo SOURCE.e
```

The exact filesystem/device names are deliberately isolated in the runtime layer so lessons never depend on emulator-specific paths.

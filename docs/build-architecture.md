# Build architecture

E-VO is an Amiga executable, not a native Linux cross-compiler.

Upstream builds E-VO from `E-VO.S` with VASM using `-Fhunkexe`. The resulting compiler therefore belongs on the Amiga side of the build boundary.

## Two-layer student environment

### 1. Host OCI

The Debian student image provides:

- reproducible downloads and checksum verification;
- course scripts;
- source validation;
- staging of source and output directories;
- orchestration of the Amiga runtime.

### 2. Amiga build runner

The Amiga runtime provides:

- AmigaDOS;
- E-VO;
- E modules;
- compilation of `.e` source;
- execution/qualification of the resulting Amiga Hunk program.

This separation is intentional. We do not pretend an Amiga executable can run natively inside the Linux container.

## Runtime policy

The course runner must eventually support a documented emulator/runtime path. The first qualification target is:

- A500-class profile
- 68000
- OCS
- PAL

The runtime layer must not redistribute copyrighted Kickstart or AmigaOS files. Students provide legally obtained system files where required.

## Build contract

The host side stages:

```text
/work/src
/work/out
```

The Amiga side sees equivalent source/output locations and runs E-VO there.

A successful build must return the produced executable to `/work/out`.

This contract allows the runtime implementation to evolve without changing every lesson.

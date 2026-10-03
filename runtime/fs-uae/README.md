# FS-UAE runtime

FS-UAE is the reference runtime for building and qualifying EduAmigaE-Game programs.

The repository supplies configuration and automation only. It does **not** ship Kickstart ROMs, AmigaOS/Workbench files, or other proprietary Amiga system material. Users provide their own legally obtained runtime files.

## Build runner

`runtime/fs-uae/run-build.sh SOURCE.e` runs E-VO inside an Amiga environment. The build host may use AmigaOS 2.04+ for reliable automation; this is a tooling environment, not a game compatibility claim.

Generated volumes are:

- `BOOT:` — generated unattended Startup-Sequence;
- `SYSTEM:` — user-supplied AmigaOS tree;
- `SRC:` — staged E source;
- `OUT:` — compiler output and completion markers;
- `RUNTIME:` — Amiga-side build scripts;
- `EVO:` — pinned E-VO distribution.

A successful build must return an Amiga Hunk executable to `build/out`. The host then verifies the Hunk container format.

## Primary game target profiles

Built programs are qualified separately from the compiler host.

### A500 / 1.x

The foundational compatibility gate is:

- A500;
- 68000;
- OCS;
- PAL;
- AmigaOS/Kickstart 1.x;
- 1 MiB practical baseline (512 KiB Chip + 512 KiB Slow).

### A1200 / 3.x

The advanced game profile is:

- A1200;
- 68020;
- AGA;
- PAL;
- AmigaOS/Kickstart 3.x;
- 2 MiB Chip baseline.

A1200-only lessons and features must be explicit and must not silently raise the A500 baseline.

## Target execution contract

`runtime/fs-uae/run-target.sh PROFILE EXECUTABLE` performs actual target execution.

Its generated volumes are:

- `BOOT:` — target qualification boot;
- `SYSTEM:` — user-supplied target AmigaOS tree;
- `TEST:` — executable under test and `RUN.TARGET`;
- `RESULT:` — Amiga-side `RUN.PASS` or `RUN.FAIL`.

The host does not infer success merely because FS-UAE started or exited. A target run passes only when the Amiga-side harness writes `RUN.PASS`.

Use:

```sh
make q3-target-a500
make q3-target-a1200
```

for real target execution. The corresponding `q3-preflight-*` targets validate supplied inputs and the artifact without claiming runtime qualification.

## Qualification boundary

Public CI tests configuration generation, Hunk validation, volume contracts, and PASS/FAIL marker semantics without proprietary ROM or OS files.

Actual A500/1.x and A1200/3.x runtime PASS evidence requires legal runtime files and a real emulator run. Do not treat public host-CI success as proof of game runtime compatibility.

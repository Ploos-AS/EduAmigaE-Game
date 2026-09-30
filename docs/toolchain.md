# Toolchain policy

## Primary compiler: E-VO

EduAmigaE-Game uses **E-VO** as its primary Amiga E compiler.

Reasons:

- it is a maintained evolution of the original Amiga E compiler;
- it retains classic m68k AmigaOS support, including 68000;
- it includes the modules needed for low-level graphics work;
- its Aminet distribution permits redistribution/use subject to its stated terms;
- it avoids making the course depend on the limited compiler in the historical Amiga E 3.3a distribution.

Canonical upstream package:

- Aminet package: `dev/e/evo.lha`

## Compatibility policy

Course source should use the traditional Amiga E language subset by default.

E-VO-specific syntax or functionality is allowed only when:

1. it materially improves the lesson or game;
2. the lesson labels it explicitly;
3. a compatibility note explains the difference.

This keeps the course useful to students exploring historical Amiga E while giving the standard course a maintained compiler.

## CPU baseline

M1-M7 baseline:

- Motorola 68000
- OCS
- PAL
- A500-class Amiga

Do not silently introduce 68020+ instructions into baseline examples.

## Reproducibility

The student environment must pin an exact E-VO archive and SHA-256 checksum before it is considered release-ready.

The course must not mirror or relicense upstream E-VO as CC BY 4.0. Upstream software retains its own terms.

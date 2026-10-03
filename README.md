# EduAmigaE-Game

Game development for the classic Commodore Amiga using Amiga E.

## Status

**M0 — project bootstrap**

EduAmigaE-Game is the game-development companion to `EduAmigaE`.
`EduAmigaE` covers the Amiga E language and system programming; this course focuses specifically on building games.

## Goals

The course takes a student from a first game loop to complete classic Amiga games while teaching how the machine actually works.

Primary game profiles:

- **A500 / 68000 / OCS / PAL / AmigaOS-Kickstart 1.x** — foundational and minimum compatibility profile; 1 MiB is the practical course baseline where appropriate.
- **A1200 / 68020 / AGA / PAL / AmigaOS-Kickstart 3.x** — advanced game profile for AGA, 020-class code and later course material.

The foundational course must remain useful on the A500 profile. Features that require the A1200 profile must be explicit rather than silently raising the baseline.

## Teaching approach

The progression is practical and project-driven:

1. first program and game loop
2. timing and frame pacing
3. input
4. bitplanes and display fundamentals
5. sprites
6. blitter graphics
7. Copper effects
8. scrolling and tile maps
9. collision detection
10. sound and music
11. game states and level structure
12. simple game AI
13. performance profiling and optimisation
14. selected 68000 assembly where it provides real value
15. packaging and releasing a complete Amiga game

The course should favour clear Amiga E first. Hardware-specific techniques are introduced deliberately rather than hidden behind a large framework.

## Student environment

Students must be able to complete the course without access to private Ploos infrastructure.

The project will therefore provide a self-contained student OCI image/toolchain containing the public tools required to build course examples and exercises. Emulator integration and reproducible build/test workflows will be added as the course matures.

## Repository layout

Planned structure:

```text
course/       lesson sources
examples/     complete runnable examples
exercises/    student exercises
solutions/    reference solutions
projects/     larger milestone games
tools/        course helper tools
student-oci/  self-contained student environment
docs/         supporting documentation
```

## Relationship to other Ploos courses

- `EduAmigaE` — Amiga E language and Amiga system programming
- `EduAmigaE-Game` — game development in Amiga E
- `EduAmigaC-Game` — Amiga game development using C-based approaches

The courses may share concepts, but EduAmigaE-Game must stand on its own pedagogically.

## Publishing

Course material is intended to use the common Ploos publishing workflow from single-source Markdown to web and book formats where applicable.

## License

Course and documentation material: **CC BY 4.0** unless otherwise noted.

Source code examples will receive an explicit software license before the first release.

# Course structure

EduAmigaE-Game is a practical game-development course for classic Amiga systems using Amiga E.

Each lesson should follow a consistent learning cycle:

1. **Goal** — what the student will build or understand.
2. **Concept** — the minimum theory needed.
3. **Code** — a small working Amiga E example.
4. **Run** — build and test it.
5. **Change** — modify behaviour or parameters.
6. **Think** — explain what the Amiga is doing underneath.
7. **Challenge** — extend the example independently.

The course should avoid hiding important Amiga concepts behind a large framework. Helper code is acceptable when it reduces irrelevant repetition, but the student should still be able to trace the path from Amiga E source to AmigaOS/custom-chip behaviour.

## Proposed modules

### Part I — Foundations

- toolchain and emulator
- game loop
- PAL timing
- keyboard and joystick
- screen coordinates and state

### Part II — Graphics

- display memory and bitplanes
- palettes
- sprites
- blitter objects
- double buffering
- Copper effects

### Part III — Worlds

- animation
- tile maps
- scrolling
- cameras
- collision

### Part IV — Sound

- Paula overview
- effects
- music
- channel/resource management

### Part V — Game systems

- state machines
- entities
- levels
- score and lives
- simple AI
- menus and presentation

### Part VI — Performance and release

- profiling
- memory placement
- custom chips vs CPU
- targeted 68000 assembly
- packaging
- testing on emulator and real hardware
- final game project

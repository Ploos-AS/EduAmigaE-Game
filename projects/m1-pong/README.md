# M1 project — Mini Pong

The first playable project is deliberately small. Its job is to prove the course workflow before graphics complexity is introduced.

## Behaviour

The project has:

- one movable paddle
- one moving ball
- screen-boundary bounce
- paddle collision
- score state
- restart
- clean quit

## Architecture

Keep these phases visible:

```text
init -> input -> update -> render -> frame sync -> repeat -> shutdown
```

The initial implementation should prefer readable Amiga E over clever optimisation.

## M1 acceptance criteria

M1 is complete when a fresh student environment can:

1. obtain the public toolchain,
2. build the supplied source,
3. produce an Amiga executable,
4. run it in the documented emulator/runtime workflow,
5. play and quit cleanly,
6. repeat the build deterministically.

No private Ploos service, package, token or repository may be required.


# Mini Pong — deterministic core

M1 now has a platform-independent game-state core in `core.e`.

The core owns:

- paddle position;
- ball position and velocity;
- logical boundaries;
- paddle collision;
- score;
- ball restart;
- quit state.

It deliberately does **not** own:

- joystick/CIA/custom-chip register reads;
- VBlank pacing;
- bitplane or sprite rendering;
- emulator setup.

That separation lets the same update logic consume synthetic input during tests and real joystick input on an Amiga.

## Logical playfield

The first M1 state model uses a 320 x 200 logical playfield. The paddle occupies x=8..15 and is 25 logical pixels high. These are game coordinates; the renderer added later decides how they map to bitplanes/sprites.

## Integration order

1. deterministic core;
2. joystick adapter fills `inputUp`, `inputDown`, and quit policy;
3. PAL pacing drives one update per game tick;
4. renderer observes `playerY`, `ballX`, `ballY`, and `score`;
5. target qualification runs the integrated executable on the documented profiles.

Keeping these layers separate is part of the course architecture, not temporary scaffolding.

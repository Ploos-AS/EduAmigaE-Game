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

# Q3 — E-VO compiler qualification

Q3 proves the compiler path independently of game code.

## Fixture

`tests/fixtures/q3-smoke.e` contains only a `main` procedure and `WriteF`.
It deliberately avoids graphics, input, modules and game-loop behaviour.

## Required evidence

A qualified run must:

1. stage `q3-smoke.e`;
2. boot the reference Amiga runner;
3. invoke E-VO 3.9.4;
4. return an executable to the host;
5. pass the Amiga Hunk header check;
6. execute under the A500/68000 qualification profile;
7. print `EduAmigaE-Game Q3 PASS`.

The Hunk header check proves the output container format only. It does **not**
by itself prove that generated instructions are 68000-compatible. That claim
requires successful execution on the 68000 qualification profile.

## Status

Infrastructure: implemented.

Runtime evidence: pending.

Do not mark Q3 PASS until an actual emulator/runtime run supplies the evidence.

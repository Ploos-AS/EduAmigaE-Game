# Lesson 2 — PAL timing and deterministic state

## Goal

Turn the lesson-1 loop into a simulation whose state advances in explicit PAL-sized ticks.

The important idea is separation: **game state changes because a simulation tick happened**, not because a particular computer happened to execute a loop a certain number of times.

## Concept

For the foundational PAL profile, the course models one game tick as 1/50 second.

Keep these two jobs separate:

1. **simulation** — calculate the next state;
2. **pacing** — decide when the next simulation tick may happen.

That distinction matters because the same game logic should produce the same sequence of states when given the same initial state and inputs.

This lesson deliberately does not hide a hardware timing implementation behind a helper. Exact VBlank/display synchronisation is introduced when the course can show the Amiga mechanism directly.

## Deterministic state

Start with state that is plain data:

```text
tick
ball x
ball velocity x
running
```

One update step is conceptually:

```text
x = x + velocity
if x reached a boundary
    reverse velocity
tick = tick + 1
```

There is no wall-clock read and no random value inside that update.

## Code

See `examples/deterministic-state/deterministic.e`.

The example runs a fixed number of simulation ticks and moves one value between two boundaries. It has no graphics yet. That makes the state transition easy to inspect before rendering is allowed to complicate the program.

## Run

Build it with the same course build path used by lesson 1. For foundational qualification, the resulting executable must remain eligible for the A500/68000/OCS/PAL/1.x target gate.

Do not claim exact 50 Hz pacing from this example alone. It demonstrates a **50 Hz simulation model**; the real pacing source is a separate concern.

## Change

Try these independently:

- change the initial velocity;
- change the left and right boundaries;
- run twice as many ticks;
- start at another X position.

For the same starting values, repeated runs should follow the same state sequence.

## Think

1. Why is a CPU-speed-dependent loop unsuitable as the game clock?
2. Why is deterministic simulation useful when debugging a collision bug?
3. What breaks determinism if an update reads an uncontrolled clock or random source?
4. Why should rendering normally observe state rather than decide game rules?

## Challenge

Add a Y position and Y velocity. Bounce independently on four logical boundaries while keeping the update deterministic.

## Next

Lesson 3 adds input. Input becomes another explicit value consumed by the update step rather than game logic reading devices from arbitrary places.

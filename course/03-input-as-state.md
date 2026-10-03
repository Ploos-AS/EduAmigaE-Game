# Lesson 3 — Input as game state

## Goal

Add player input without letting device reads spread through the game logic.

By the end of the lesson, input is sampled once per tick, represented as state, and then consumed by the deterministic update.

## Concept

A useful game loop separates three things:

```text
sample device -> input state -> update game state
```

The update should not care whether `left` came from a joystick, keyboard, replay file, or test harness.

For the first example we therefore use a synthetic input source. The Amiga hardware reader is added separately so that the deterministic core remains testable and understandable.

## Held and pressed

Two common meanings are different:

- **held** — the control is down during this tick;
- **pressed** — the control changed from up to down on this tick.

Movement usually uses held state. Actions such as pause, restart, or menu selection often need an edge/pressed event so one physical press does not trigger every frame.

## Input state

The lesson starts with:

```text
left
right
quit
```

The update receives those values and changes the player state. It does not read hardware itself.

## Code

See `examples/input-state/input-state.e`.

Its synthetic input deliberately changes at known ticks. That means repeated runs receive the same input sequence and therefore produce the same game-state sequence.

## Run

Build the example with the normal course build path. It remains a foundational example and must not require APIs newer than the A500/68000/OCS/PAL/1.x profile.

This example proves the architecture, not physical joystick support.

## Change

Try these changes:

- make left movement last longer;
- overlap left and right and decide what the game should do;
- add a fire value;
- make quit happen earlier;
- change movement speed without changing the input source.

## Think

1. Why is reading the joystick directly inside collision code a poor design?
2. Why are deterministic input sequences useful for reproducing bugs?
3. When should a game use held state instead of a pressed edge?
4. What should happen if left and right are both active?

## Challenge

Add previous-fire and current-fire state and derive a one-tick `firePressed` event.

## Next

The next step connects this input-state model to real classic-Amiga controls while keeping the game update independent of the device reader.

# Lesson 1 — The first game loop

## Goal

Build the smallest useful Amiga E game structure: initialise, update, render and shut down cleanly.

By the end of this lesson the student should understand that a game is a state machine driven by frames, not a long sequence of delays.

## The loop

A first model is:

```text
initialise
while running
    read input
    update game state
    render frame
    wait for next frame
endwhile
shutdown
```

For the PAL baseline we target 50 updates per second. Later lessons will distinguish simulation rate, rendering rate and hardware synchronisation.

## First exercise

Create a program with:

- a running flag
- a player X/Y position
- an input/update phase
- a render phase
- one frame synchronisation point
- a clean exit path

Do not optimise yet. Keep each phase obvious enough to inspect and modify.

## Think

1. What happens if game logic runs as fast as the CPU allows?
2. Why should input be sampled every frame?
3. Why is cleanup part of the game architecture rather than an afterthought?

## Next

Lesson 2 turns this loop into a tiny playable game and introduces deterministic game state.

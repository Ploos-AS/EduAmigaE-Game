# Lesson 4 — Classic Amiga joystick adapter

## Goal

Connect the logical input state from lesson 3 to a real digital joystick while keeping hardware access in one small adapter.

This lesson targets the foundational A500/68000/OCS/PAL/1.x profile.

## Hardware model

Classic Amiga digital joystick directions are read from `JOY0DAT` or `JOY1DAT`. The direction encoding is shared with the mouse counters, so up/down are reconstructed with XOR rather than exposed as four simple bits.

For a `JOYxDAT` word:

```text
right = bit 1
left  = bit 9
down  = bit 1 XOR bit 0
up    = bit 9 XOR bit 8
```

The primary fire buttons are active-low inputs in CIA-A port A: bit 6 corresponds to controller port 0 and bit 7 to controller port 1.

## Architecture

Keep the hardware boundary narrow:

```text
JOY1DAT + CIAAPRA
        |
        v
sampleJoystick()
        |
        v
logical input state
        |
        v
updateGame()
```

Only the adapter knows register addresses or bit encoding. Game rules continue to consume logical values such as `inputLeft`, `inputRight`, and `inputFire`.

## Port choice

The game examples use controller port 1 (the second physical controller connector, conventionally the joystick port), therefore `JOY1DAT` and CIA-A fire bit 7.

## Safety and scope

The adapter only **reads** the direction and fire inputs. It does not reconfigure CIA direction registers, POT lines, interrupts, or other shared hardware.

Direct custom-chip/CIA access is intentional in this low-level game course, but it must remain isolated so a later OS-friendly or test adapter can implement the same logical contract.

## Exercise

1. Sample the joystick once per game tick.
2. Copy the decoded values into logical input state.
3. Move a logical player position with left/right.
4. Count a fire action only on the transition from released to pressed.
5. Keep collision/update code free of hardware register reads.

## Think

1. Why are up/down XOR combinations on classic Amiga hardware?
2. Why is the fire signal inverted?
3. Why should the adapter sample once and let the rest of the frame use that snapshot?
4. What becomes easier to test when hardware reads are isolated?

## Next

The next foundation step combines coordinates, input and deterministic update into the first genuinely interactive Mini Pong state before graphics rendering is introduced.

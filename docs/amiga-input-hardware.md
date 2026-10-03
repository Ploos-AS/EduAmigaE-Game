# Classic Amiga input references

The joystick adapter lessons use the Amiga Hardware Reference Manual controller-port model as the hardware contract.

Relevant facts:

- `JOY0DAT` is at `$DFF00A`; `JOY1DAT` is at `$DFF00C`.
- right = JOY bit 1.
- left = JOY bit 9.
- down/back = bit 1 XOR bit 0.
- up/forward = bit 9 XOR bit 8.
- CIA-A PRA is at `$BFE001`.
- fire for controller port 0 is CIA-A PRA bit 6; fire for controller port 1 is bit 7.
- fire is active low.

These values are hardware facts, not an EduAmigaE-Game-specific convention. Game code should consume the decoded logical state rather than duplicate this encoding.

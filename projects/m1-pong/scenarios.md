# Mini Pong deterministic scenarios

These scenarios are the behavioural contract for the M1 game core. They are intentionally implementation-neutral so the same cases can later be executed by an E-VO/Amiga test harness.

All scenarios represent one call to `updateGame()`.

| Scenario | Initial state / input | Expected state after one update |
| --- | --- | --- |
| paddle-up | playerY=100, inputUp=TRUE | playerY=98 |
| paddle-down | playerY=100, inputDown=TRUE | playerY=102 |
| clamp-top | playerY=1, inputUp=TRUE | playerY=0 |
| clamp-bottom | playerY=174, inputDown=TRUE | playerY=175 |
| top-bounce | ballX=100, ballY=0, ballVX=1, ballVY=-1 | ballX=101, ballY=0, ballVX=1, ballVY=1 |
| bottom-bounce | ballX=100, ballY=199, ballVX=1, ballVY=1 | ballX=101, ballY=199, ballVX=1, ballVY=-1 |
| paddle-hit | playerY=100, ballX=16, ballY=110, ballVX=-1, ballVY=1, score=0 | ballX=16, ballY=111, ballVX=1, ballVY=1, score=1 |
| paddle-miss | playerY=100, ballX=0, ballY=50, ballVX=-1, ballVY=1 | ballX=160, ballY=100, ballVX=1, ballVY=1 |
| right-wall | ballX=318, ballY=100, ballVX=1, ballVY=1 | ballX=319, ballY=101, ballVX=-1, ballVY=1 |
| quit | running=TRUE, inputQuit=TRUE | running=FALSE |

## Rules

- unspecified state keeps the defaults from `core.e`;
- input is a snapshot for this update only;
- the test harness must compare resulting game state, not rendering;
- no scenario may depend on CPU speed, wall-clock time, emulator frame rate, or hardware input;
- later changes to game rules must update both the implementation and this behavioural contract deliberately.

## Future execution

The intended qualification path is:

```text
scenario
   |
   v
E-VO test program + core update
   |
   v
actual state
   |
   v
compare with expected state
   |
   v
PASS / FAIL marker
```

Until that runner exists, this file is a reviewed behavioural specification rather than runtime evidence.

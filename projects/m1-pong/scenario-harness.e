/* Mini Pong M1 deterministic scenario harness.
 *
 * Exercises the exported core module and its real updateGame().
 */

MODULE 'core'

DEF failures=0
DEF state:pongstate

PROC check(value,expected)
  IF value<>expected THEN failures:=failures+1
ENDPROC

PROC main()
  resetGame(state)
  state.inputUp:=TRUE
  updateGame(state)
  check(state.playerY,98)

  resetGame(state)
  state.inputDown:=TRUE
  updateGame(state)
  check(state.playerY,102)

  resetGame(state)
  state.playerY:=1
  state.inputUp:=TRUE
  updateGame(state)
  check(state.playerY,0)

  resetGame(state)
  state.playerY:=174
  state.inputDown:=TRUE
  updateGame(state)
  check(state.playerY,175)

  resetGame(state)
  state.ballX:=100
  state.ballY:=0
  state.ballVY:=-1
  updateGame(state)
  check(state.ballX,101)
  check(state.ballY,0)
  check(state.ballVY,1)

  resetGame(state)
  state.ballX:=100
  state.ballY:=199
  state.ballVY:=1
  updateGame(state)
  check(state.ballX,101)
  check(state.ballY,199)
  check(state.ballVY,-1)

  resetGame(state)
  state.playerY:=100
  state.ballX:=16
  state.ballY:=110
  state.ballVX:=-1
  state.score:=0
  updateGame(state)
  check(state.ballX,16)
  check(state.ballY,111)
  check(state.ballVX,1)
  check(state.score,1)

  resetGame(state)
  state.ballX:=0
  state.ballY:=50
  state.ballVX:=-1
  updateGame(state)
  check(state.ballX,160)
  check(state.ballY,100)
  check(state.ballVX,1)
  check(state.ballVY,1)

  resetGame(state)
  state.ballX:=318
  state.ballY:=100
  state.ballVX:=1
  updateGame(state)
  check(state.ballX,319)
  check(state.ballY,101)
  check(state.ballVX,-1)

  resetGame(state)
  state.inputQuit:=TRUE
  updateGame(state)
  check(state.running,FALSE)

  IF failures=0
    WriteF('M1 PONG SCENARIOS PASS\n')
  ELSE
    WriteF('M1 PONG SCENARIOS FAIL: \d\n',failures)
  ENDIF
ENDPROC

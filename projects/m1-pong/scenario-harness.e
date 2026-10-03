/* Mini Pong M1 deterministic scenario harness.
 *
 * This harness exercises the real updateGame() from core.e.
 * It is intended for the E-VO/Amiga qualification runner.
 */

MODULE 'core.e'

DEF failures=0

PROC resetState()
  running:=TRUE
  playerY:=100
  ballX:=160
  ballY:=100
  ballVX:=1
  ballVY:=1
  score:=0
  inputUp:=FALSE
  inputDown:=FALSE
  inputQuit:=FALSE
ENDPROC

PROC check(value,expected)
  IF value<>expected THEN failures:=failures+1
ENDPROC

PROC main()
  resetState()
  inputUp:=TRUE
  updateGame()
  check(playerY,98)

  resetState()
  inputDown:=TRUE
  updateGame()
  check(playerY,102)

  resetState()
  playerY:=1
  inputUp:=TRUE
  updateGame()
  check(playerY,0)

  resetState()
  playerY:=174
  inputDown:=TRUE
  updateGame()
  check(playerY,175)

  resetState()
  ballX:=100
  ballY:=0
  ballVY:=-1
  updateGame()
  check(ballX,101)
  check(ballY,0)
  check(ballVY,1)

  resetState()
  ballX:=100
  ballY:=199
  ballVY:=1
  updateGame()
  check(ballX,101)
  check(ballY,199)
  check(ballVY,-1)

  resetState()
  playerY:=100
  ballX:=16
  ballY:=110
  ballVX:=-1
  score:=0
  updateGame()
  check(ballX,16)
  check(ballY,111)
  check(ballVX,1)
  check(score,1)

  resetState()
  ballX:=0
  ballY:=50
  ballVX:=-1
  updateGame()
  check(ballX,160)
  check(ballY,100)
  check(ballVX,1)
  check(ballVY,1)

  resetState()
  ballX:=318
  ballY:=100
  ballVX:=1
  updateGame()
  check(ballX,319)
  check(ballY,101)
  check(ballVX,-1)

  resetState()
  inputQuit:=TRUE
  updateGame()
  check(running,FALSE)

  IF failures=0
    WriteF('M1 PONG SCENARIOS PASS\n')
  ELSE
    WriteF('M1 PONG SCENARIOS FAIL: \d\n',failures)
  ENDIF
ENDPROC

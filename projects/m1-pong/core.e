/* EduAmigaE-Game: Mini Pong deterministic game core.
 *
 * Pure state/update module: no hardware reads, rendering, timing or OS calls.
 */
OPT MODULE
OPT EXPORT

OBJECT pongstate
  running:LONG
  playerY:LONG
  ballX:LONG
  ballY:LONG
  ballVX:LONG
  ballVY:LONG
  score:LONG
  inputUp:LONG
  inputDown:LONG
  inputQuit:LONG
ENDOBJECT

PROC resetGame(s:PTR TO pongstate)
  s.running:=TRUE
  s.playerY:=100
  s.ballX:=160
  s.ballY:=100
  s.ballVX:=1
  s.ballVY:=1
  s.score:=0
  s.inputUp:=FALSE
  s.inputDown:=FALSE
  s.inputQuit:=FALSE
ENDPROC

PROC updateGame(s:PTR TO pongstate)
  IF s.inputUp THEN s.playerY:=s.playerY-2
  IF s.inputDown THEN s.playerY:=s.playerY+2

  IF s.playerY<0 THEN s.playerY:=0
  IF s.playerY>175 THEN s.playerY:=175

  s.ballX:=s.ballX+s.ballVX
  s.ballY:=s.ballY+s.ballVY

  IF s.ballY<=0
    s.ballY:=0
    s.ballVY:=1
  ENDIF
  IF s.ballY>=199
    s.ballY:=199
    s.ballVY:=-1
  ENDIF

  IF s.ballVX<0
    IF s.ballX<=15
      IF s.ballX>=8
        IF s.ballY>=s.playerY
          IF s.ballY<=s.playerY+24
            s.ballX:=16
            s.ballVX:=1
            s.score:=s.score+1
          ENDIF
        ENDIF
      ENDIF
    ENDIF
  ENDIF

  IF s.ballX<0
    s.ballX:=160
    s.ballY:=100
    s.ballVX:=1
    s.ballVY:=1
  ENDIF

  IF s.ballX>=319
    s.ballX:=319
    s.ballVX:=-1
  ENDIF

  IF s.inputQuit THEN s.running:=FALSE
ENDPROC

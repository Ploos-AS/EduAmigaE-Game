/* EduAmigaE-Game: Mini Pong deterministic game core.
 *
 * No hardware reads and no rendering live here. A platform adapter fills the
 * logical input values; a renderer observes the game state.
 */

DEF running=TRUE
DEF playerY=100
DEF ballX=160
DEF ballY=100
DEF ballVX=1
DEF ballVY=1
DEF score=0
DEF inputUp=FALSE
DEF inputDown=FALSE
DEF inputQuit=FALSE

PROC updateGame()
  IF inputUp THEN playerY:=playerY-2
  IF inputDown THEN playerY:=playerY+2

  IF playerY<0 THEN playerY:=0
  IF playerY>175 THEN playerY:=175

  ballX:=ballX+ballVX
  ballY:=ballY+ballVY

  IF ballY<=0
    ballY:=0
    ballVY:=1
  ENDIF
  IF ballY>=199
    ballY:=199
    ballVY:=-1
  ENDIF

  /* Logical paddle: x=8..15, y=playerY..playerY+24. */
  IF ballVX<0
    IF ballX<=15
      IF ballX>=8
        IF ballY>=playerY
          IF ballY<=playerY+24
            ballX:=16
            ballVX:=1
            score:=score+1
          ENDIF
        ENDIF
      ENDIF
    ENDIF
  ENDIF

  /* Missing the left paddle restarts the ball state. */
  IF ballX<0
    ballX:=160
    ballY:=100
    ballVX:=1
    ballVY:=1
  ENDIF

  /* Right wall stands in for the second side during M1. */
  IF ballX>=319
    ballX:=319
    ballVX:=-1
  ENDIF

  IF inputQuit THEN running:=FALSE
ENDPROC

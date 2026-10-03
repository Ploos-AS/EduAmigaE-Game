/* EduAmigaE-Game: smallest visible game-loop state example.
 *
 * This intentionally keeps hardware rendering out of lesson 1.
 * The state transitions are the lesson.
 * This foundational example must remain compatible with the A500/1.x profile.
 */

DEF running=TRUE
DEF frame=0
DEF playerX=0

PROC main()
  WHILE running
    readInput()
    updateGame()
    renderGame()
    frameSync()
  ENDWHILE
ENDPROC

PROC readInput()
  /* M1 scaffold: real input is introduced next. */
  IF frame>=250 THEN running:=FALSE
ENDPROC

PROC updateGame()
  playerX:=playerX+1
  IF playerX>=320 THEN playerX:=0
ENDPROC

PROC renderGame()
  /* Rendering arrives after the loop/state model is understood. */
ENDPROC

PROC frameSync()
  Delay(1)
  frame:=frame+1
ENDPROC

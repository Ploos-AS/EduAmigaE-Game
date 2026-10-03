/* EduAmigaE-Game lesson 3: input as state.
 *
 * Synthetic input keeps this example deterministic. A later Amiga-specific
 * adapter samples real controls and fills the same logical input state.
 */

DEF running=TRUE
DEF tick=0
DEF playerX=160
DEF inputLeft=FALSE
DEF inputRight=FALSE
DEF inputQuit=FALSE

PROC main()
  WHILE running
    sampleInput()
    updateGame()
    tick:=tick+1
  ENDWHILE
ENDPROC

PROC sampleInput()
  inputLeft:=FALSE
  inputRight:=FALSE
  inputQuit:=FALSE

  IF tick<50 THEN inputLeft:=TRUE
  IF tick>=50
    IF tick<100 THEN inputRight:=TRUE
  ENDIF
  IF tick>=150 THEN inputQuit:=TRUE
ENDPROC

PROC updateGame()
  IF inputLeft THEN playerX:=playerX-1
  IF inputRight THEN playerX:=playerX+1

  IF playerX<0 THEN playerX:=0
  IF playerX>319 THEN playerX:=319

  IF inputQuit THEN running:=FALSE
ENDPROC

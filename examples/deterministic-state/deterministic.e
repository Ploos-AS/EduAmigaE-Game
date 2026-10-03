/* EduAmigaE-Game lesson 2: deterministic state.
 *
 * No graphics or hardware timing yet. The update function demonstrates
 * state evolution that does not depend on host CPU speed.
 */

DEF running=TRUE
DEF tick=0
DEF maxTicks=250
DEF ballX=10
DEF ballVX=1
DEF leftEdge=0
DEF rightEdge=319

PROC main()
  WHILE running
    updateGame()
  ENDWHILE
ENDPROC

PROC updateGame()
  ballX:=ballX+ballVX

  IF ballX>=rightEdge THEN ballVX:=-1
  IF ballX<=leftEdge THEN ballVX:=1

  tick:=tick+1
  IF tick>=maxTicks THEN running:=FALSE
ENDPROC

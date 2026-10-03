/* EduAmigaE-Game lesson 4: classic Amiga joystick adapter.
 *
 * Controller port 1:
 *   JOY1DAT = $DFF00C (16-bit read)
 *   CIA-A PRA = $BFE001 (8-bit read), fire = active-low bit 7
 *
 * Hardware reads stay inside these procedures. The game consumes only
 * logical input state.
 */

DEF inputLeft=FALSE
DEF inputRight=FALSE
DEF inputUp=FALSE
DEF inputDown=FALSE
DEF inputFire=FALSE

PROC readJoy1Dat()
  MOVEQ #0,D0
  MOVE.W $DFF00C,D0
ENDPROC D0

PROC readCiaAPra()
  MOVEQ #0,D0
  MOVE.B $BFE001,D0
ENDPROC D0

PROC sampleJoystick()
  DEF joy,cia

  joy:=readJoy1Dat()
  cia:=readCiaAPra()

  inputRight:=(joy AND $0002)<>0
  inputLeft:=(joy AND $0200)<>0
  inputDown:=((joy AND $0002)<>0)<>((joy AND $0001)<>0)
  inputUp:=((joy AND $0200)<>0)<>((joy AND $0100)<>0)
  inputFire:=(cia AND $80)=0
ENDPROC

PROC main()
  sampleJoystick()
ENDPROC

#!/bin/sh
set -eu

core=projects/m1-pong/core.e
test -f "$core"

# The M1 core must stay a pure state/update layer.
! grep -q '\$DFF' "$core"
! grep -q '\$BFE' "$core"
! grep -q 'Delay(' "$core"

# Lock the foundational logical playfield and paddle model.
grep -q 'DEF playerY=100' "$core"
grep -q 'DEF ballX=160' "$core"
grep -q 'DEF ballY=100' "$core"
grep -q 'IF playerY<0 THEN playerY:=0' "$core"
grep -q 'IF playerY>175 THEN playerY:=175' "$core"
grep -q 'IF ballY<=0' "$core"
grep -q 'IF ballY>=199' "$core"

# Collision, score, restart and quit must remain explicit state transitions.
grep -q 'IF ballVX<0' "$core"
grep -q 'score:=score+1' "$core"
grep -q 'IF ballX<0' "$core"
grep -q 'ballX:=160' "$core"
grep -q 'IF ballX>=319' "$core"
grep -q 'IF inputQuit THEN running:=FALSE' "$core"

echo "M1 Pong core contract tests: PASS"

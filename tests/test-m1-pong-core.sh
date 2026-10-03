#!/bin/sh
set -eu

core=projects/m1-pong/core.e
harness=projects/m1-pong/scenario-harness.e
test -f "$core"
test -f "$harness"

# Core is an exported E-VO module with explicit state.
grep -q '^OPT MODULE' "$core"
grep -q '^OPT EXPORT' "$core"
grep -q '^OBJECT pongstate' "$core"
grep -q '^PROC resetGame(s:PTR TO pongstate)' "$core"
grep -q '^PROC updateGame(s:PTR TO pongstate)' "$core"

# The M1 core must stay a pure state/update layer.
! grep -q '\$DFF' "$core"
! grep -q '\$BFE' "$core"
! grep -q 'Delay(' "$core"

# Lock foundational rules.
grep -q 's.playerY<0 THEN s.playerY:=0' "$core"
grep -q 's.playerY>175 THEN s.playerY:=175' "$core"
grep -q 's.ballY<=0' "$core"
grep -q 's.ballY>=199' "$core"
grep -q 's.score:=s.score+1' "$core"
grep -q 's.ballX<0' "$core"
grep -q 's.ballX:=160' "$core"
grep -q 's.ballX>=319' "$core"
grep -q 's.inputQuit THEN s.running:=FALSE' "$core"

# Harness must consume the module API, not source-include core.e.
grep -q "^MODULE 'core'" "$harness"
! grep -q "^MODULE 'core.e'" "$harness"
grep -q '^DEF state:pongstate' "$harness"
grep -q 'updateGame(state)' "$harness"

echo "M1 Pong core contract tests: PASS"

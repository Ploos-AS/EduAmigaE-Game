#!/bin/sh
set -eu
root="$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)"
. "$root/runtime/fs-uae/target-profiles.sh"

EDUAMIGAE_A500_KICKSTART=/rom/a500
EDUAMIGAE_A500_SYSTEM=/system/a500
load_target_profile a500-1x
test "$PROFILE_MODEL" = A500
test "$PROFILE_CHIP" = 512
test "$PROFILE_SLOW" = 512
test "$PROFILE_KICK" = /rom/a500
test "$PROFILE_SYSTEM" = /system/a500
test "$PROFILE_KICK_ENV" = EDUAMIGAE_A500_KICKSTART
test "$PROFILE_SYSTEM_ENV" = EDUAMIGAE_A500_SYSTEM
test "$PROFILE_LABEL" = 'A500 / 68000 / OCS / PAL / AmigaOS-Kickstart 1.x'

EDUAMIGAE_A1200_KICKSTART=/rom/a1200
EDUAMIGAE_A1200_SYSTEM=/system/a1200
load_target_profile a1200-3x
test "$PROFILE_MODEL" = A1200
test "$PROFILE_CHIP" = 2048
test "$PROFILE_SLOW" = 0
test "$PROFILE_KICK" = /rom/a1200
test "$PROFILE_SYSTEM" = /system/a1200
test "$PROFILE_KICK_ENV" = EDUAMIGAE_A1200_KICKSTART
test "$PROFILE_SYSTEM_ENV" = EDUAMIGAE_A1200_SYSTEM
test "$PROFILE_LABEL" = 'A1200 / 68020 / AGA / PAL / AmigaOS-Kickstart 3.x'

set +e
load_target_profile unknown-profile > /dev/null 2>&1
rc=$?
set -e
test "$rc" -eq 2

unset EDUAMIGAE_A500_KICKSTART
set +e
load_target_profile a500-1x > /dev/null 2>&1
rc=$?
set -e
test "$rc" -eq 2

echo "target profile contract tests: PASS"

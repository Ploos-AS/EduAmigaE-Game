#!/bin/sh
# Source this file, then call load_target_profile PROFILE.
load_target_profile() {
  case "$1" in
    a500-1x)
      PROFILE_MODEL=A500
      PROFILE_CHIP=512
      PROFILE_SLOW=512
      PROFILE_LABEL='A500 / 68000 / OCS / PAL / AmigaOS-Kickstart 1.x'
      PROFILE_KICK_ENV=EDUAMIGAE_A500_KICKSTART
      PROFILE_SYSTEM_ENV=EDUAMIGAE_A500_SYSTEM
      ;;
    a1200-3x)
      PROFILE_MODEL=A1200
      PROFILE_CHIP=2048
      PROFILE_SLOW=0
      PROFILE_LABEL='A1200 / 68020 / AGA / PAL / AmigaOS-Kickstart 3.x'
      PROFILE_KICK_ENV=EDUAMIGAE_A1200_KICKSTART
      PROFILE_SYSTEM_ENV=EDUAMIGAE_A1200_SYSTEM
      ;;
    *)
      echo "unknown target profile: $1" >&2
      return 2
      ;;
  esac

  eval "PROFILE_KICK=\${$PROFILE_KICK_ENV:-}"
  eval "PROFILE_SYSTEM=\${$PROFILE_SYSTEM_ENV:-}"
  test -n "$PROFILE_KICK" || { echo "set $PROFILE_KICK_ENV" >&2; return 2; }
  test -n "$PROFILE_SYSTEM" || { echo "set $PROFILE_SYSTEM_ENV" >&2; return 2; }
}

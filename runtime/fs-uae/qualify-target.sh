#!/bin/sh
set -eu

profile="${1:?usage: qualify-target.sh PROFILE AMIGA_EXECUTABLE}"
artifact="${2:?usage: qualify-target.sh PROFILE AMIGA_EXECUTABLE}"
root="$(CDPATH= cd -- "$(dirname "$0")/../.." && pwd)"

case "$profile" in
  a500-1x)
    : "${EDUAMIGAE_A500_KICKSTART:?set EDUAMIGAE_A500_KICKSTART to a legally obtained 1.x Kickstart ROM}"
    : "${EDUAMIGAE_A500_SYSTEM:?set EDUAMIGAE_A500_SYSTEM to a legally obtained AmigaOS 1.x system directory}"
    kick="$EDUAMIGAE_A500_KICKSTART"
    system="$EDUAMIGAE_A500_SYSTEM"
    label="A500 / 68000 / OCS / PAL / AmigaOS-Kickstart 1.x"
    ;;
  a1200-3x)
    : "${EDUAMIGAE_A1200_KICKSTART:?set EDUAMIGAE_A1200_KICKSTART to a legally obtained 3.x Kickstart ROM}"
    : "${EDUAMIGAE_A1200_SYSTEM:?set EDUAMIGAE_A1200_SYSTEM to a legally obtained AmigaOS 3.x system directory}"
    kick="$EDUAMIGAE_A1200_KICKSTART"
    system="$EDUAMIGAE_A1200_SYSTEM"
    label="A1200 / 68020 / AGA / PAL / AmigaOS-Kickstart 3.x"
    ;;
  *)
    echo "unknown target profile: $profile" >&2
    exit 2
    ;;
esac

test -f "$artifact" || { echo "missing artifact: $artifact" >&2; exit 2; }
test -f "$kick" || { echo "missing Kickstart for $profile: $kick" >&2; exit 2; }
test -d "$system" || { echo "missing system directory for $profile: $system" >&2; exit 2; }

python3 "$root/tools/check-amiga-hunk.py" "$artifact"
echo "target gate prepared: $label"
echo "runtime execution evidence is required before this artifact is qualified"

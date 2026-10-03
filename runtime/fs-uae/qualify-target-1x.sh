#!/bin/sh
set -eu

artifact="${1:?usage: qualify-target-1x.sh AMIGA_EXECUTABLE}"
root="$(CDPATH= cd -- "$(dirname "$0")/../.." && pwd)"

: "${EDUAMIGAE_1X_KICKSTART:?set EDUAMIGAE_1X_KICKSTART to a legally obtained 1.x Kickstart ROM}"
: "${EDUAMIGAE_1X_SYSTEM:?set EDUAMIGAE_1X_SYSTEM to a legally obtained AmigaOS 1.x system directory}"

test -f "$artifact" || { echo "missing artifact: $artifact" >&2; exit 2; }
test -f "$EDUAMIGAE_1X_KICKSTART" || { echo "missing 1.x Kickstart: $EDUAMIGAE_1X_KICKSTART" >&2; exit 2; }
test -d "$EDUAMIGAE_1X_SYSTEM" || { echo "missing 1.x system directory: $EDUAMIGAE_1X_SYSTEM" >&2; exit 2; }

python3 "$root/tools/check-amiga-hunk.py" "$artifact"

echo "target gate prepared: A500 / 68000 / OCS / PAL / AmigaOS-Kickstart 1.x"
echo "runtime execution evidence is required before this artifact is qualified"

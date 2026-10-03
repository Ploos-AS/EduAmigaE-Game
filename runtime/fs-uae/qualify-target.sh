#!/bin/sh
set -eu
profile="${1:?usage: qualify-target.sh PROFILE AMIGA_EXECUTABLE}"
artifact="${2:?usage: qualify-target.sh PROFILE AMIGA_EXECUTABLE}"
root="$(CDPATH= cd -- "$(dirname "$0")/../.." && pwd)"
. "$root/runtime/fs-uae/target-profiles.sh"
load_target_profile "$profile"
test -f "$artifact" || { echo "missing artifact: $artifact" >&2; exit 2; }
test -f "$PROFILE_KICK" || { echo "missing Kickstart for $profile: $PROFILE_KICK" >&2; exit 2; }
test -d "$PROFILE_SYSTEM" || { echo "missing system directory for $profile: $PROFILE_SYSTEM" >&2; exit 2; }
python3 "$root/tools/check-amiga-hunk.py" "$artifact"
echo "target gate prepared: $PROFILE_LABEL"
echo "runtime execution evidence is required before this artifact is qualified"

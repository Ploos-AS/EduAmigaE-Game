#!/bin/sh
set -eu
profile="${1:?usage: make-target-config.sh PROFILE ARTIFACT_DIR}"
artifacts="${2:?usage: make-target-config.sh PROFILE ARTIFACT_DIR}"
root="$(CDPATH= cd -- "$(dirname "$0")/../.." && pwd)"

. "$root/runtime/fs-uae/target-profiles.sh"
load_target_profile "$profile"
model="$PROFILE_MODEL"; chip="$PROFILE_CHIP"; slow="$PROFILE_SLOW"
kick="$PROFILE_KICK"; system="$PROFILE_SYSTEM"

test -f "$kick" || { echo "missing Kickstart: $kick" >&2; exit 2; }
test -d "$system" || { echo "missing system directory: $system" >&2; exit 2; }
test -d "$artifacts" || { echo "missing artifact directory: $artifacts" >&2; exit 2; }
mkdir -p "$root/build/target-boot/S" "$root/build/target-result"
cp "$root/runtime/amiga/target-boot/S/Startup-Sequence" "$root/build/target-boot/S/Startup-Sequence"
out="$root/build/target-$profile.fs-uae"
esc() { printf '%s' "$1" | sed 's/[&|]/\\&/g'; }
sed -e "s|@MODEL@|$model|g" -e "s|@CHIP@|$chip|g" -e "s|@SLOW@|$slow|g" \
  -e "s|@KICKSTART@|$(esc "$kick")|g" -e "s|@BOOT@|$(esc "$root/build/target-boot")|g" \
  -e "s|@SYSTEM@|$(esc "$system")|g" -e "s|@ARTIFACTS@|$(esc "$artifacts")|g" \
  -e "s|@RESULT@|$(esc "$root/build/target-result")|g" "$root/runtime/fs-uae/target.fs-uae.in" > "$out"
echo "$out"

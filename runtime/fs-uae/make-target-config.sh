#!/bin/sh
set -eu
profile="${1:?usage: make-target-config.sh PROFILE ARTIFACT_DIR}"
artifacts="${2:?usage: make-target-config.sh PROFILE ARTIFACT_DIR}"
root="$(CDPATH= cd -- "$(dirname "$0")/../.." && pwd)"

case "$profile" in
  a500-1x)
    : "${EDUAMIGAE_A500_KICKSTART:?set EDUAMIGAE_A500_KICKSTART}"
    : "${EDUAMIGAE_A500_SYSTEM:?set EDUAMIGAE_A500_SYSTEM}"
    model=A500; chip=512; slow=512
    kick="$EDUAMIGAE_A500_KICKSTART"; system="$EDUAMIGAE_A500_SYSTEM"
    ;;
  a1200-3x)
    : "${EDUAMIGAE_A1200_KICKSTART:?set EDUAMIGAE_A1200_KICKSTART}"
    : "${EDUAMIGAE_A1200_SYSTEM:?set EDUAMIGAE_A1200_SYSTEM}"
    model=A1200; chip=2048; slow=0
    kick="$EDUAMIGAE_A1200_KICKSTART"; system="$EDUAMIGAE_A1200_SYSTEM"
    ;;
  *) echo "unknown target profile: $profile" >&2; exit 2 ;;
esac

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

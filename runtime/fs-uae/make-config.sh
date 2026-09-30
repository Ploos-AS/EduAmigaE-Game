#!/bin/sh
set -eu

: "${EDUAMIGAE_KICKSTART:?set EDUAMIGAE_KICKSTART}"
: "${EDUAMIGAE_SYSTEM:?set EDUAMIGAE_SYSTEM}"
: "${EDUAMIGAE_EVO_ROOT:?set EDUAMIGAE_EVO_ROOT}"

root="$(CDPATH= cd -- "$(dirname "$0")/../.." && pwd)"
template="$root/runtime/fs-uae/eduamigae-game.fs-uae.in"
out="$root/build/eduamigae-game.fs-uae"

mkdir -p "$root/build/src" "$root/build/out"

for p in "$EDUAMIGAE_KICKSTART" "$EDUAMIGAE_SYSTEM" "$EDUAMIGAE_EVO_ROOT"; do
  test -e "$p" || { echo "missing path: $p" >&2; exit 2; }
done

esc() { printf '%s' "$1" | sed 's/[&|]/\\&/g'; }

sed \
  -e "s|@KICKSTART@|$(esc "$EDUAMIGAE_KICKSTART")|g" \
  -e "s|@SYSTEM@|$(esc "$EDUAMIGAE_SYSTEM")|g" \
  -e "s|@SRC@|$(esc "$root/build/src")|g" \
  -e "s|@OUT@|$(esc "$root/build/out")|g" \
  -e "s|@RUNTIME@|$(esc "$root/runtime/amiga")|g" \
  -e "s|@EVO@|$(esc "$EDUAMIGAE_EVO_ROOT")|g" \
  "$template" > "$out"

echo "$out"

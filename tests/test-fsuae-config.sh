#!/bin/sh
set -eu

root="$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

mkdir -p "$tmp/system" "$tmp/evo"
: > "$tmp/kick.rom"

EDUAMIGAE_KICKSTART="$tmp/kick.rom" \
EDUAMIGAE_SYSTEM="$tmp/system" \
EDUAMIGAE_EVO_ROOT="$tmp/evo" \
  "$root/runtime/fs-uae/make-config.sh" >/dev/null

cfg="$root/build/eduamigae-game.fs-uae"
grep -q '^amiga_model = A500$' "$cfg"
grep -q "^kickstart_file = $tmp/kick.rom$" "$cfg"
grep -q "^hard_drive_1 = $root/build/src$" "$cfg"
grep -q "^hard_drive_2 = $root/build/out$" "$cfg"

echo "FS-UAE config tests: PASS"

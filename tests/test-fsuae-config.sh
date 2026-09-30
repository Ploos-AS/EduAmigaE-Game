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
  sh "$root/runtime/fs-uae/make-config.sh" >/dev/null

cfg="$root/build/eduamigae-game.fs-uae"
grep -q '^amiga_model = A500$' "$cfg"
grep -q "^kickstart_file = $tmp/kick.rom$" "$cfg"
grep -q "^hard_drive_0 = $root/build/boot$" "$cfg"
grep -q "^hard_drive_1 = $tmp/system$" "$cfg"
grep -q "^hard_drive_2 = $root/build/src$" "$cfg"
grep -q "^hard_drive_3 = $root/build/out$" "$cfg"
grep -q "^hard_drive_4 = $root/runtime/amiga$" "$cfg"
grep -q "^hard_drive_5 = $tmp/evo$" "$cfg"

for pair in "0 BOOT" "1 SYSTEM" "2 SRC" "3 OUT" "4 RUNTIME" "5 EVO"; do
  set -- $pair
  grep -q "^hard_drive_$1_label = $2$" "$cfg"
done

echo "FS-UAE config tests: PASS"

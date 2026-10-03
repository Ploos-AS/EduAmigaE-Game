#!/bin/sh
set -eu
root="$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
printf '\000\000\003\363' > "$tmp/game"
: > "$tmp/a500.rom"
: > "$tmp/a1200.rom"
mkdir -p "$tmp/a500-system" "$tmp/a1200-system"

EDUAMIGAE_A500_KICKSTART="$tmp/a500.rom" EDUAMIGAE_A500_SYSTEM="$tmp/a500-system" \
  sh "$root/runtime/fs-uae/qualify-target.sh" a500-1x "$tmp/game" > "$tmp/a500.out"
grep -q 'A500 / 68000 / OCS / PAL / AmigaOS-Kickstart 1.x' "$tmp/a500.out"

EDUAMIGAE_A1200_KICKSTART="$tmp/a1200.rom" EDUAMIGAE_A1200_SYSTEM="$tmp/a1200-system" \
  sh "$root/runtime/fs-uae/qualify-target.sh" a1200-3x "$tmp/game" > "$tmp/a1200.out"
grep -q 'A1200 / 68020 / AGA / PAL / AmigaOS-Kickstart 3.x' "$tmp/a1200.out"

grep -q 'runtime execution evidence is required' "$tmp/a500.out"
grep -q 'runtime execution evidence is required' "$tmp/a1200.out"

EDUAMIGAE_A500_KICKSTART="$tmp/a500.rom" EDUAMIGAE_A500_SYSTEM="$tmp/a500-system" \
  sh "$root/runtime/fs-uae/make-target-config.sh" a500-1x "$tmp" >/dev/null
cfg="$root/build/target-a500-1x.fs-uae"
grep -q '^amiga_model = A500
echo "target profile gate tests: PASS"
 "$cfg"
grep -q '^chip_memory = 512
echo "target profile gate tests: PASS"
 "$cfg"
grep -q '^slow_memory = 512
echo "target profile gate tests: PASS"
 "$cfg"
grep -q '^hard_drive_1_label = TEST
echo "target profile gate tests: PASS"
 "$cfg"

EDUAMIGAE_A1200_KICKSTART="$tmp/a1200.rom" EDUAMIGAE_A1200_SYSTEM="$tmp/a1200-system" \
  sh "$root/runtime/fs-uae/make-target-config.sh" a1200-3x "$tmp" >/dev/null
cfg="$root/build/target-a1200-3x.fs-uae"
grep -q '^amiga_model = A1200
echo "target profile gate tests: PASS"
 "$cfg"
grep -q '^chip_memory = 2048
echo "target profile gate tests: PASS"
 "$cfg"
grep -q '^slow_memory = 0
echo "target profile gate tests: PASS"
 "$cfg"
grep -q '^hard_drive_1_label = TEST
echo "target profile gate tests: PASS"
 "$cfg"
echo "target profile gate tests: PASS"

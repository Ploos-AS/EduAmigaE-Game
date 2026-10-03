#!/bin/sh
set -eu

root="$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

printf '\000\000\003\363' > "$tmp/game"
: > "$tmp/kick.rom"
mkdir -p "$tmp/system"

EDUAMIGAE_1X_KICKSTART="$tmp/kick.rom" \
EDUAMIGAE_1X_SYSTEM="$tmp/system" \
  sh "$root/runtime/fs-uae/qualify-target-1x.sh" "$tmp/game" > "$tmp/out"

grep -q 'A500 / 68000 / OCS / PAL / AmigaOS-Kickstart 1.x' "$tmp/out"
grep -q 'runtime execution evidence is required' "$tmp/out"

echo "1.x target gate tests: PASS"

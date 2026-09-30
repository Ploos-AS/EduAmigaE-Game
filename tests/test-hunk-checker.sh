#!/bin/sh
set -eu

root="$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

printf '\000\000\003\363\000\000\000\000' > "$tmp/good"
printf 'ELF!' > "$tmp/bad"

python3 "$root/tools/check-amiga-hunk.py" "$tmp/good" >/dev/null

if python3 "$root/tools/check-amiga-hunk.py" "$tmp/bad" >/dev/null 2>&1; then
  echo "non-Hunk file incorrectly accepted" >&2
  exit 1
fi

echo "Hunk checker tests: PASS"

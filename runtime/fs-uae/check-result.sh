#!/bin/sh
set -eu

root="$(CDPATH= cd -- "$(dirname "$0")/../.." && pwd)"
out="$root/build/out"

if [ -f "$out/BUILD.PASS" ]; then
  echo "Amiga build: PASS"
  exit 0
fi

if [ -f "$out/BUILD.FAIL" ]; then
  echo "Amiga build: FAIL" >&2
  exit 20
fi

echo "Amiga build: no completion marker" >&2
exit 21

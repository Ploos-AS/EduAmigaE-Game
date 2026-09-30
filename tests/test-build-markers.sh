#!/bin/sh
set -eu

root="$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)"
mkdir -p "$root/build/out"
rm -f "$root/build/out/BUILD.PASS" "$root/build/out/BUILD.FAIL"

if "$root/runtime/fs-uae/check-result.sh" >/dev/null 2>&1; then
  echo "missing marker should fail" >&2
  exit 1
fi

: > "$root/build/out/BUILD.PASS"
"$root/runtime/fs-uae/check-result.sh" >/dev/null
rm -f "$root/build/out/BUILD.PASS"

: > "$root/build/out/BUILD.FAIL"
if "$root/runtime/fs-uae/check-result.sh" >/dev/null 2>&1; then
  echo "FAIL marker should fail" >&2
  exit 1
fi

rm -f "$root/build/out/BUILD.FAIL"
echo "build marker tests: PASS"

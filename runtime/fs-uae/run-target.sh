#!/bin/sh
set -eu
profile="${1:?usage: run-target.sh PROFILE AMIGA_EXECUTABLE}"
artifact="${2:?usage: run-target.sh PROFILE AMIGA_EXECUTABLE}"
root="$(CDPATH= cd -- "$(dirname "$0")/../.." && pwd)"
command -v fs-uae >/dev/null 2>&1 || { echo "error: fs-uae not found" >&2; exit 127; }
test -f "$artifact" || { echo "missing artifact: $artifact" >&2; exit 2; }

artdir="$(CDPATH= cd -- "$(dirname "$artifact")" && pwd)"
name="$(basename "$artifact")"
printf '%s\n' "$name" > "$artdir/RUN.TARGET"
rm -rf "$root/build/target-result"
mkdir -p "$root/build/target-result"

cfg="$(sh "$root/runtime/fs-uae/make-target-config.sh" "$profile" "$artdir")"
echo "starting FS-UAE target qualification: $profile / $name"
fs-uae "$cfg"

if [ -f "$root/build/target-result/RUN.PASS" ]; then
  echo "target runtime PASS: $profile / $name"
  exit 0
fi
if [ -f "$root/build/target-result/RUN.FAIL" ]; then
  echo "target runtime FAIL: $profile / $name" >&2
  cat "$root/build/target-result/RUN.FAIL" >&2 || true
  exit 20
fi
echo "target runtime did not produce a completion marker" >&2
exit 21

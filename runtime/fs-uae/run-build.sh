#!/bin/sh
set -eu

src="${1:?usage: run-build.sh SOURCE.e}"
root="$(CDPATH= cd -- "$(dirname "$0")/../.." && pwd)"
out="${src%.e}"

: "${EDUAMIGAE_KICKSTART:?set EDUAMIGAE_KICKSTART to your legally obtained Kickstart ROM}"
: "${EDUAMIGAE_SYSTEM:?set EDUAMIGAE_SYSTEM to your Amiga system directory}"
: "${EDUAMIGAE_EVO_ROOT:?set EDUAMIGAE_EVO_ROOT to the extracted E-VO distribution}"

command -v fs-uae >/dev/null 2>&1 || {
  echo "error: fs-uae not found" >&2
  exit 127
}

test -f "$root/build/src/$src" || {
  echo "error: staged source not found: build/src/$src" >&2
  exit 2
}

rm -f "$root/build/out/BUILD.PASS" "$root/build/out/BUILD.FAIL" "$root/build/out/$out"
printf '%s\n' "$src" > "$root/build/src/BUILD.SOURCE"

cfg="$("$root/runtime/fs-uae/make-config.sh")"
echo "starting FS-UAE build runner for $src"
fs-uae "$cfg"

"$root/runtime/fs-uae/check-result.sh"

test -f "$root/build/out/$out" || {
  echo "error: Amiga reported PASS but output is missing: $out" >&2
  exit 22
}

#!/bin/sh
set -eu

src="${1:?usage: run-build.sh SOURCE.e}"
root="$(CDPATH= cd -- "$(dirname "$0")/../.." && pwd)"

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

rm -f "$root/build/out/BUILD.PASS" "$root/build/out/BUILD.FAIL"
printf '%s\n' "$src" > "$root/build/src/BUILD.SOURCE"

cfg="$("$root/runtime/fs-uae/make-config.sh")"

echo "starting FS-UAE build runner for $src"
echo "config: $cfg"

# Q2 still requires runtime evidence before this invocation is declared
# qualified. The command itself is now explicit and reviewable.
fs-uae "$cfg"

"$root/runtime/fs-uae/check-result.sh"

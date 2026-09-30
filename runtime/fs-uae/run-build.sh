#!/bin/sh
set -eu

src="${1:?usage: run-build.sh SOURCE.e}"

: "${EDUAMIGAE_KICKSTART:?set EDUAMIGAE_KICKSTART to your legally obtained Kickstart ROM}"
: "${EDUAMIGAE_SYSTEM:?set EDUAMIGAE_SYSTEM to your Amiga system directory or image}"

command -v fs-uae >/dev/null 2>&1 || {
  echo "error: fs-uae not found" >&2
  exit 127
}

test -f "build/src/$src" || {
  echo "error: staged source not found: build/src/$src" >&2
  exit 2
}

mkdir -p build/out

echo "FS-UAE runner scaffold"
echo "source:    build/src/$src"
echo "output:    build/out"
echo "Kickstart: user supplied"
echo "System:    user supplied"

# M1 qualification gate:
# We intentionally stop before inventing FS-UAE CLI/config semantics for
# unattended AmigaDOS execution. The next runtime qualification step will pin
# a tested FS-UAE configuration and boot command.
echo "error: unattended FS-UAE boot/AmigaDOS invocation not qualified yet" >&2
exit 4

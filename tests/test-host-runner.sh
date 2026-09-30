#!/bin/sh
set -eu

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

cp tools/eduamigae-game "$tmp/tool"
mkdir -p "$tmp/example"
printf 'PROC main()\nENDPROC\n' > "$tmp/example/test.e"

cd "$tmp"
sh ./tool stage example/test.e

test -f build/src/test.e

if sh ./tool build example/test.e >/dev/null 2>&1; then
  echo "expected build without runner to fail" >&2
  exit 1
fi

echo "host runner tests: PASS"

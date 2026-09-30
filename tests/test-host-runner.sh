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

set +e
sh ./tool build example/test.e >build-without-runner.log 2>&1
rc=$?
set -e

if [ "$rc" -eq 0 ]; then
  echo "expected build without runner to fail" >&2
  cat build-without-runner.log >&2
  exit 1
fi

if [ "$rc" -ne 3 ]; then
  echo "expected exit 3 without runner, got $rc" >&2
  cat build-without-runner.log >&2
  exit 1
fi

grep -q 'EDUAMIGAE_RUNNER is not configured' build-without-runner.log

echo "host runner tests: PASS"

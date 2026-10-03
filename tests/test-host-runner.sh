#!/bin/sh
set -eu

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

mkdir -p "$tmp/tools" "$tmp/example"
cp tools/eduamigae-game "$tmp/tools/eduamigae-game"
printf 'PROC main()\nENDPROC\n' > "$tmp/example/test.e"

cd "$tmp"
sh tools/eduamigae-game stage example/test.e
test -f build/src/test.e

set +e
sh tools/eduamigae-game build example/test.e >build-without-runner.log 2>&1
rc=$?
set -e

if [ "$rc" -ne 3 ]; then
  echo "expected exit 3 without runner, got $rc" >&2
  cat build-without-runner.log >&2
  exit 1
fi

grep -q 'EDUAMIGAE_RUNNER is not configured' build-without-runner.log

printf '#!/bin/sh\nexit 0\n' > fake-runner
chmod +x fake-runner
set +e
EDUAMIGAE_RUNNER="$tmp/fake-runner" sh tools/eduamigae-game build example/test.e >build-with-runner.log 2>&1
rc=$?
set -e
test "$rc" -eq 4
grep -q 'expected output missing' build-with-runner.log

echo "host runner tests: PASS"

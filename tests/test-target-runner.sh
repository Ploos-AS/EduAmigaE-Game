#!/bin/sh
set -eu
root="$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
mkdir -p "$tmp/bin" "$tmp/system" "$tmp/artifacts"
: > "$tmp/kick.rom"
printf '\000\000\003\363' > "$tmp/artifacts/game"

cat > "$tmp/bin/fs-uae" <<EOF
#!/bin/sh
mkdir -p "$root/build/target-result"
case "\${FAKE_RESULT:-none}" in
  pass) echo PASS > "$root/build/target-result/RUN.PASS" ;;
  fail) echo simulated-failure > "$root/build/target-result/RUN.FAIL" ;;
esac
EOF
chmod +x "$tmp/bin/fs-uae"

run() {
  PATH="$tmp/bin:$PATH" EDUAMIGAE_A500_KICKSTART="$tmp/kick.rom" EDUAMIGAE_A500_SYSTEM="$tmp/system" \
    FAKE_RESULT="$1" sh "$root/runtime/fs-uae/run-target.sh" a500-1x "$tmp/artifacts/game"
}

run pass > "$tmp/pass.log"
grep -q 'target runtime PASS' "$tmp/pass.log"
grep -q '^game$' "$tmp/artifacts/RUN.TARGET"

set +e
run fail > "$tmp/fail.log" 2>&1
rc=$?
set -e
test "$rc" -eq 20
grep -q 'target runtime FAIL' "$tmp/fail.log"

set +e
run none > "$tmp/none.log" 2>&1
rc=$?
set -e
test "$rc" -eq 21
grep -q 'did not produce a completion marker' "$tmp/none.log"

echo "target runner marker tests: PASS"

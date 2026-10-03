#!/bin/sh
set -eu

case "${1:-help}" in
  help)
    cat <<'EOF'
EduAmigaE-Game student environment

Commands:
  help      show this message
  doctor    verify the public student toolchain

E-VO is pinned by the course and installed in EDUAMIGAE_EVO_ROOT.
The compiler is an Amiga executable and is run through the course runtime,
not as a native Linux program.
EOF
    ;;
  doctor)
    printf '%-12s' 'git'; git --version
    printf '%-12s' 'make'; make --version | head -n 1
    printf '%-12s' 'curl'; curl --version | head -n 1
    printf '%-12s' 'lhasa'; lha --version 2>&1 | head -n 1 || true

    : "${EDUAMIGAE_EVO_ROOT:?EDUAMIGAE_EVO_ROOT is not set}"
    : "${EDUAMIGAE_EVO_VERSION:?EDUAMIGAE_EVO_VERSION is not set}"
    test -d "$EDUAMIGAE_EVO_ROOT" || {
      echo "E-VO root missing: $EDUAMIGAE_EVO_ROOT" >&2
      exit 10
    }
    test -d "$EDUAMIGAE_EVO_ROOT/Modules" || {
      echo "E-VO Modules directory missing" >&2
      exit 11
    }

    evo_bin="$(find "$EDUAMIGAE_EVO_ROOT" -type f \( -name EVO -o -name E-VO \) | head -n 1)"
    test -n "$evo_bin" || {
      echo "E-VO compiler executable missing" >&2
      exit 12
    }

    echo "E-VO       $EDUAMIGAE_EVO_VERSION"
    echo "E-VO root  $EDUAMIGAE_EVO_ROOT"
    echo "E-VO bin   $evo_bin"
    echo "student toolchain: PASS"
    ;;
  *)
    echo "Unknown command: $1" >&2
    exit 2
    ;;
esac

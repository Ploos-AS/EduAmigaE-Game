#!/bin/sh
set -eu

case "${1:-help}" in
  help)
    cat <<'EOF'
EduAmigaE-Game student environment

Commands:
  help      show this message
  doctor    verify the base environment

The Amiga E compiler will be enabled once its public redistributable source
and checksum have been pinned by the course.
EOF
    ;;
  doctor)
    printf '%-12s' 'git'; git --version
    printf '%-12s' 'make'; make --version | head -n 1
    printf '%-12s' 'curl'; curl --version | head -n 1
    echo "Amiga E compiler: not pinned yet"
    ;;
  *)
    echo "Unknown command: $1" >&2
    exit 2
    ;;
esac

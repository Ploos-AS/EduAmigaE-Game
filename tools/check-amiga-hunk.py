#!/usr/bin/env python3
"""Minimal structural check for an Amiga Hunk executable."""
import struct
import sys
from pathlib import Path

HUNK_HEADER = 0x000003F3

def main() -> int:
    if len(sys.argv) != 2:
        print("usage: check-amiga-hunk.py FILE", file=sys.stderr)
        return 2

    path = Path(sys.argv[1])
    data = path.read_bytes()
    if len(data) < 4:
        print(f"{path}: too small to be an Amiga Hunk executable", file=sys.stderr)
        return 1

    magic = struct.unpack(">I", data[:4])[0]
    if magic != HUNK_HEADER:
        print(f"{path}: bad Hunk header 0x{magic:08x}", file=sys.stderr)
        return 1

    print(f"{path}: Amiga Hunk executable header PASS")
    return 0

if __name__ == "__main__":
    raise SystemExit(main())

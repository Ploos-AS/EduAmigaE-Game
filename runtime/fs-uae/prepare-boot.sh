#!/bin/sh
set -eu

root="$(CDPATH= cd -- "$(dirname "$0")/../.." && pwd)"
boot="$root/build/boot"

rm -rf "$boot"
mkdir -p "$boot/S"
cp "$root/runtime/amiga/boot/S/Startup-Sequence" "$boot/S/Startup-Sequence"

echo "$boot"

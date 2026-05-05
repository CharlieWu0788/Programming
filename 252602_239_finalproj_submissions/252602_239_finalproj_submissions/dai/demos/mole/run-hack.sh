#!/bin/bash
set -e

HERE=$(cd "$(dirname "$0")" && pwd)
ROOT="$HERE/../.."
BUILD="$HERE/build-hack"
mkdir -p "$BUILD"

JC="${JACK_COMPILER:-$ROOT/11/JackCompiler.py}"
VMEMU="${VM_EMULATOR:-VMEmulator.sh}"

cp "$ROOT/12/"*.jack "$BUILD/"
cp "$HERE/Main.jack" "$BUILD/"

python3 "$JC" "$BUILD"
"$VMEMU" "$BUILD"

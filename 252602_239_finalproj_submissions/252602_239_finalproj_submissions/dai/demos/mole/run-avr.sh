#!/bin/bash
set -e

HERE=$(cd "$(dirname "$0")" && pwd)
ROOT="$HERE/../.."
BUILD="$HERE/build"
mkdir -p "$BUILD"

JC="${JACK_COMPILER:-$ROOT/11/JackCompiler.py}"

cp "$ROOT/12/"*.jack "$BUILD/"
cp "$HERE/Main.jack" "$BUILD/"

python3 "$JC" "$BUILD"

cat "$BUILD/Sys.vm" \
    "$BUILD/Main.vm" \
    "$BUILD/Memory.vm" \
    "$BUILD/Keyboard.vm" \
    "$BUILD/Screen.vm" \
    "$BUILD/Output.vm" \
    "$BUILD/Math.vm" > "$BUILD/mole.vm"

cd "$ROOT"
./build.sh "$BUILD/mole.vm"

#!/bin/bash
# build a Jack program that needs the OS.

set -e

DIR="$1"
if [[ -z "$DIR" || ! -f "$DIR/Main.jack" ]]; then
    echo "usage: $0 <dir-with-Main.jack>"
    exit 1
fi

ROOT=$(cd "$(dirname "$0")" && pwd)
NAME=$(basename "$DIR")
BUILD="$DIR/build"
mkdir -p "$BUILD"

JC="${JACK_COMPILER:-$ROOT/11/JackCompiler.py}"

cp "$ROOT/12/"*.jack "$BUILD/"
cp "$DIR/Main.jack" "$BUILD/"

python3 "$JC" "$BUILD"

# Sys.vm first so the translator pre-scan finds Sys.init.
cat "$BUILD/Sys.vm" \
    "$BUILD/Main.vm" \
    "$BUILD/Memory.vm" \
    "$BUILD/Keyboard.vm" \
    "$BUILD/Screen.vm" \
    "$BUILD/Output.vm" \
    "$BUILD/Math.vm" > "$BUILD/$NAME.vm"

cd "$ROOT"
./build.sh "$BUILD/$NAME.vm"

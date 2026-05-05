#!/bin/bash
set -e

HERE=$(cd "$(dirname "$0")" && pwd)
ROOT="$HERE/../.."
BUILD="$HERE/build"
mkdir -p "$BUILD"

JC="${JACK_COMPILER:-$ROOT/11/JackCompiler.sh}"

cp "$ROOT/12/"*.jack "$BUILD/"
cp "$HERE/Main.jack" "$BUILD/"

"$JC" "$BUILD"

cat "$BUILD/Main.vm" "$BUILD/Memory.vm" "$BUILD/Keyboard.vm" "$BUILD/Sys.vm" "$BUILD/Math.vm" > "$BUILD/Simon.vm"

cd "$ROOT"
./build.sh "$BUILD/Simon.vm"

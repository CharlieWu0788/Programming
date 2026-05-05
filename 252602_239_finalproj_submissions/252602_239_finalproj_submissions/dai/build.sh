#!/bin/bash
# build + flash one program.
# HACK2AVR_BARE=1 skips the runtime, NO_FLASH=1 skips the flash step.

set -e

FILE="$1"
BASE="${FILE%.*}"

if [[ "$FILE" == *.vm ]]; then
    python3 avr_translator.py "$FILE"
    SFILE="$BASE.S"
else
    SFILE="$FILE"
fi

RUNTIME=""
if [[ -z "$HACK2AVR_BARE" && -d runtime ]]; then
    RUNTIME=$(ls runtime/*.S 2>/dev/null)
fi

avr-gcc -mmcu=atmega328p -nostdlib -o "$BASE.elf" "$SFILE" $RUNTIME
avr-objcopy -O ihex "$BASE.elf" "$BASE.hex"

if [[ -n "$NO_FLASH" ]]; then
    exit 0
fi

avrdude -c usbasp -p m328p -B 125kHz -V -U flash:w:"$BASE.hex"

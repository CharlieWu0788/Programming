# hack2avr

**This readme is formatted with helps of Language model. (e.g. the structure tree and the tables)**

Take a Jack program from the nand2tetris course and run it in **two** places: the standard Hack VM emulator on a laptop, and a physical ATmega328P sitting on a breadboard with an OLED screen and four buttons. Same Jack source, same compiled VM bytecode - different last-mile pipelines.

```
                          one Jack source
                                │
                  10/JackAnalyzer.py + 11/JackCompiler.py
                                │
                       a single set of .vm files
                                │
                ┌───────────────┴───────────────┐
                │                               │
        nand2tetris VMEmulator         avr_translator.py  (this project)
                │                               │
        runs the .vm directly             AVR assembly (.S)
                │                               │
                │                       avr-gcc + avr-objcopy
                │                               │
                │                          Intel HEX
                │                               │
                │                          avrdude / USBASP
                │                               │
                │                         ATmega328P chip
                │                               │
        Hack screen + keyboard          OLED + 4 buttons + 4 LEDs
```

That fork point - the .vm - is where the project lives. Above the fork, everything is platform-neutral; below, two different worlds. The whole point is that the Jack source on top of the diagram doesn't know or care which leg of the Y it's running on.

This is roughly 30% P9 (the basic translator + 12 small Jack programs verified on LEDs) and 70% the final project (real call/return, memory-mapped I/O, OLED via I2C, the Jack OS, three cross-target demos).

---

## for you to try

### dependencies

```bash
# macOS
brew tap osx-cross/avr
brew install avr-gcc avrdude
# python3 should already be there

# linux
sudo apt install gcc-avr avr-libc avrdude python3
```

You also need the nand2tetris course tools (specifically `VMEmulator.sh` and `JackCompiler` if you don't want to use the bundled one). Set `VM_EMULATOR=/path/to/VMEmulator.sh` if it's not on `PATH`.

### build and run a demo on the breadboard

```bash
./demos/simon/run-avr.sh   # Simon
./demos/mole/run-avr.sh    # Whack-a-Mole (uses OLED)
./demos/draw/run-avr.sh    # Etch-a-Sketch (uses OLED)
```

Each script does the same thing: stage the Jack OS (`12/`) and the demo's `Main.jack` into a build dir, run the user's `11/JackCompiler.py` to produce per-class `.vm` files, concatenate them in Sys-first order, hand off to `avr_translator.py`, link the runtime under `runtime/`, and flash via USBASP. It expects the USBASP to be plugged in. Set `NO_FLASH=1` in front of the script if you just want a dry build.

### run the same demo in the Hack VM emulator

Each demo also ships a `for-emulator/` folder with the seven per-class `.vm` files (Main + the six OS classes) ready to load:

```bash
demos/simon/for-emulator/   ← drag this folder into VMEmulator.sh
demos/mole/for-emulator/
demos/draw/for-emulator/
```

Or run the wrapper which compiles fresh and launches the emulator:

```bash
./demos/simon/run-hack.sh
./demos/mole/run-hack.sh
./demos/draw/run-hack.sh
```

The emulator picks up `Sys.init` as the entry, runs `Memory.init` / `Math.init` / `Screen.init` / `Output.init` in order, then dispatches into `Main.main`.

### controls

| Demo | What it does | AVR keys | Hack keys |
|---|---|---|---|
| Simon | Memory game. Watch a sequence flash, repeat it. Wrong = game over. | PD2/PD3/PD4/PD5 | `1`/`2`/`3`/`4` |
| Whack-a-Mole | A random mole lights up; press its slot. Wrong = game over. | PD2/PD3/PD4/PD5 | `1`/`2`/`3`/`4` |
| Etch-a-Sketch | Cursor walks the canvas, leaves a trail. Wraps at edges. | PD2 = up, PD3 = down, PD4 = left, PD5 = right | `1`/`2`/`3`/`4` |

There's no "start over" button on AVR - power-cycle the chip (re-plug USBASP). On the emulator, just close and reload the program.

The two physical-button-based demos rely on the Timer0 ISR in `runtime/led_mirror.S` to write button codes to SRAM `0x0800`, and the Hack reads from the keyboard memory-mapped register. The Jack code reads from address 24576 either way; the translator's MMIO redirect (Stage 2) makes the AVR side land at `0x0800`.

---

## what's where

```
hack2avr/
├── 10/                    P10 - Jack syntax analyzer (the user's .py)
├── 11/                    P11 - full Jack compiler (the user's .py)
├── 12/                    P12 - Jack OS, single source for both targets
│   ├── Memory.jack            peek/poke + bump alloc
│   ├── Math.jack              shift-and-add multiply, bit-shift divide, sqrt
│   ├── Sys.jack               init / halt / wait / error
│   ├── Keyboard.jack          keyPressed / readChar
│   ├── Screen.jack            drawPixel / drawLine / drawRectangle / clearScreen
│   └── Output.jack            printChar / printInt / println (printString omitted)
│
├── avr_translator.py      VM-to-AVR translator. Core of the project.
├── build.sh               translate one .vm or .S, link runtime, flash
├── build_with_os.sh       compile a Main.jack + 12/, then build.sh it
│
├── runtime/               hand-written AVR assembly, linked into every build
│   ├── vectors.S              vector table at 0x0000 + trampolines
│   ├── startup.S              _reset: SP/Y/DDR init, OLED bring-up, Timer setup
│   ├── led_mirror.S           Timer0 ISR - LED mirror + button poll
│   ├── oled_refresh.S         Timer1 ISR - pushes framebuffer to OLED via I2C
│   ├── i2c.S                  TWI primitives (init/start/write/stop)
│   └── ssd1306.S              SSD1306 init sequence + framebuffer push
│
├── tests_hardware/        standalone .S smoke tests
│   ├── blink.S                P9 - one LED blinking, "is the chip alive"
│   ├── test_leds.S            P9 - all four LEDs
│   ├── oled_pixel_walk.S      P12 - animate framebuffer, verify ISR refreshes
│   └── buttons_live.S         P12 - Timer0 button poll → LED mirror end-to-end
│
├── tests/                 P9 hand-written .vm files (regression suite)
├── jack/                  P9 demo programs (1-9) + P12 stage milestones (13-16)
└── demos/                 cross-target final demos
    ├── simon/                 4-step memory game (works with LEDs alone)
    ├── mole/                  Whack-a-Mole (uses OLED)
    └── draw/                  Etch-a-Sketch (uses OLED)
```

Each `demos/*/` directory has a `Main.jack` (the game logic), `run-avr.sh` and `run-hack.sh`, a `build/` populated by the AVR pipeline, and a `for-emulator/` with just the seven per-class `.vm` files for the VMEmulator.

---

## P9 - the basic VM translator

The first half was straightforward retargeting. The nand2tetris course defines a stack-based VM with commands like `push constant 7` and `add`. The standard P7-P8 translator emits Hack assembly. Our `avr_translator.py` follows the same Parser/CodeWriter shape but emits AVR instead.

The interesting part is that everything in the Hack VM is a 16-bit word and AVR is an 8-bit chip with 32 8-bit registers. So every 16-bit operation became two 8-bit instructions. `push constant 7` becomes:

```asm
ldi r16, 7            ; load immediate low byte
ldi r18, 0            ; high byte is zero
st  Y+, r16           ; store low byte, post-increment Y
st  Y+, r18           ; store high byte
```

`add` pops two pairs, adds them low byte first then carries into high:

```asm
ld  r19, -Y           ; pop b high
ld  r17, -Y           ; pop b low
ld  r18, -Y           ; pop a high
ld  r16, -Y           ; pop a low
add r16, r17          ; low byte sum
adc r18, r19          ; high byte sum with carry
st  Y+, r16           ; push result low
st  Y+, r18           ; push result high
```

The `Y` register pair (`r28:r29`) is the VM stack pointer. It grows upward from `0x0100`. We tried using AVR's hardware SP at first but it grows downward and only does 8-bit push/pop - using `Y` with explicit `st`/`ld` is cleaner for 16-bit values.

### memory layout (P9)

| Region | SRAM | What goes there |
|---|---|---|
| VM stack | 0x0100–0x01FF | grows upward from 0x0100 |
| Statics | 0x0200+ | static variables, 2 bytes each |
| Temp | 0x0210+ | temp 0 through temp 7 |

### registers (P9)

| Register | Role |
|---|---|
| Y (r28:r29) | VM stack pointer |
| r16, r17 | scratch low bytes |
| r18, r19 | scratch high bytes |
| r4:r5 | LCL - local segment base |

### supported in P9

- All push/pop variants for `constant` / `static` / `temp` / `local`
- All nine arithmetic/logic ops (`add`, `sub`, `neg`, `eq`, `gt`, `lt`, `and`, `or`, `not`)
- `label` / `goto` / `if-goto`
- `function` / `return` as **stubs** - only Main.main, no real frame save/restore. Function pushes N zeros for locals, return reads local 0 and writes the low 4 bits to `PORTB`/`PORTC` (the four LEDs) and halts.

### twelve P9 programs

Numbered 1 through 9, each one is a small Jack program designed to exercise one new feature of the translator. The result is shown by lighting some pattern on the four breadboard LEDs.

| Program | What it tests |
|---|---|
| 1_arithmetic | `add`, `sub` |
| 2_bitwise_or | `or` |
| 3_bitwise_not | `not`, `and` |
| 4_conditional | `gt`, `if-goto`, `goto`, `label` |
| 5_while_loop | repeated branching |
| 6_fibonacci | 4 local variables, deeper stack |
| 7_factorial | nested while loops |
| 8_max | multiple if-else blocks |
| 9_shift | `x+x` patterns |

All twelve verified on hardware before P12 work began.

---

## P12 final 

### real function/call/return

P9 left these as stubs because we only ever ran `Main.main`. P12 needed real recursive Jack programs to work, so the translator now implements the proper Hack VM calling convention with one twist.

The standard convention pushes five words onto the VM stack at every call site: the return address followed by the caller's `LCL` / `ARG` / `THIS` / `THAT`. We do it differently - we push only the four frame pointers (8 bytes) and use AVR's hardware `rcall`/`ret`, which keeps the return PC on the AVR hardware stack, separate from the VM stack. This matches the spirit of "use what avr-gcc gives you" rather than building everything from scratch on top of SRAM.

The frame pointers live in registers, not memory. That's faster than Hack's memory-based virtual registers and easy on the eyes:

| Register pair | Role |
|---|---|
| r4:r5 | LCL |
| r6:r7 | ARG |
| r8:r9 | THIS |
| r10:r11 | THAT |

Within `writeReturn`, we do real frame teardown (read saved pointers from memory, restore them in order, `ret`), unless the function is `Main.main` _and_ the program doesn't use `Sys.init` - that's a backward-compatibility path so the original P9 demos still work without an OS.

### MMIO redirection 

The Hack VM puts the screen at memory addresses 16384–24575 and the keyboard at 24576. A Jack program writes to those addresses and pixels appear; reads from 24576 give the current key code.

ATmega328P has 2 KB of SRAM, so addresses ≥ 16384 don't physically exist. The translator catches every `push that` / `pop that` / `push this` / `pop this` and emits an inline range check. If the address is in the screen range (`0x4000–0x5FFF`), the store/load gets remapped into the 1024-byte SRAM framebuffer at `0x0400`. If it's the keyboard (`≥0x6000`), it goes to byte `0x0800`. Otherwise it's a regular SRAM access.

The Jack OS in `12/` is unchanged from what it would look like on the standard nand2tetris platform. `Memory.poke(16384, value)` always means "write to the screen"; the meaning of "the screen" just differs underneath.

### the runtime (`runtime/*.S`)

This is hand-written AVR assembly that's automatically linked into every build (the build script picks up everything in `runtime/` unless you set `HACK2AVR_BARE=1`). It owns everything that has nothing to do with Jack:

- **`vectors.S`** - interrupt vector table at `.section .vectors` so the linker drops it at flash address `0x0000`. Each vector is one `rjmp` to a trampoline (also kept in `.vectors`); the trampolines do absolute `jmp` to the real handlers somewhere in `.text`. The trampolines exist because once the Jack OS is linked in, .text grows past 4 KB and direct `rjmp` from the vector table can't reach.
- **`startup.S`** - `_reset` does the bootstrap: clears `r1`, sets up the hardware stack at `RAMEND`, sets up the VM stack `Y` at `0x0100`, zeroes the frame pointers and the screen buffer, configures `DDRB`/`DDRC`/`DDRD` and pull-ups, brings up the SSD1306 (calls `ssd1306_init`), starts Timer0 (LED mirror + button polling, ~16 ms tick) and Timer1 (OLED refresh, ~33 ms tick), enables interrupts, and `jmp`s to the translator-emitted `main:`.
- **`led_mirror.S`** - Timer0 overflow ISR. It mirrors the low 4 bits of byte `0x0400` to the four LEDs and polls `PIND[2..5]` to write a button code (1, 2, 3, or 4 / 0 if none) to byte `0x0800`. Both jobs share one ISR per the README's "OLED refresh and keyboard polling can share one timer" suggestion.
- **`oled_refresh.S`** - Timer1 COMPA ISR. Calls `ssd1306_refresh` which streams the 1024-byte framebuffer over I2C. Takes about 23 ms of the 32 ms tick window.
- **`i2c.S`** - minimal polled TWI primitives (`i2c_init`, `i2c_start`, `i2c_write`, `i2c_stop`) targeting 400 kHz. No interrupt-driven state machine.
- **`ssd1306.S`** - SSD1306 driver. Init sequence is a 25-byte table walked with `lpm`. `ssd1306_refresh` sends the whole framebuffer in one transaction.

### the Jack OS (`12/`)

Same source on both targets. Uses only platform-neutral Jack - no inline assembly, no target-specific tricks. Each class is small enough that you can hold the whole thing in your head at once.

- `Memory.jack` - `peek` and `poke` use the standard "set THAT to address, read/write `that[0]`" trick. Because the AVR translator catches `push/pop that 0`, the same code works on both targets.
- `Math.jack` - shift-and-add multiply (16 iterations), recursive bit-shift divide, abs/min/max/sqrt. The interesting choice was dropping the `static Array twoToThe` table that the canonical Hack book version uses - it would require `Memory.alloc` to return an address that's valid on both Hack and AVR, which doesn't exist (Hack heap base 2048 is past the entire AVR SRAM). Instead the bit masks are computed inline by doubling.
- `Sys.jack` - `init`, `halt`, `wait`, `error`. `Sys.init` is the entry point: runs `Memory.init` / `Math.init` / `Screen.init` / `Output.init` then dispatches to `Main.main` then halts.
- `Keyboard.jack` - `keyPressed` reads `Memory.peek(24576)`. `readChar` blocks until press-and-release.
- `Screen.jack` - `drawPixel`, `drawLine` (axis-aligned only), `drawHLine`, `drawVLine`, `drawRectangle`, `clearScreen`. Uses Hack screen layout (16-pixel words at `16384 + y*32 + x/16`); the translator handles the AVR-side mapping.
- `Output.jack` - `printChar` / `printInt` / `println` exist but they draw a single pixel per character (no actual font). `printString` is deliberately omitted because it would pull in the `String` class which we don't ship.

### Sys.init bootstrap wiring

The translator pre-scans the input `.vm` for the literal string `function Sys.init`. If it finds it, the emitted `main:` does an absolute `call Sys_init` instead of falling straight into `Main_main`. That makes `Main.main`'s return go through the real return path (not the P9 LED-halt hack), and `Sys.init`'s `do Sys.halt()` is what eventually traps the program.

If `Sys.init` is _not_ in the .vm - like for the small P9 hand-written tests - `main:` falls through into the first function defined in the file, and `Main.main`'s return uses the P9 LED display + halt behavior. Backward compatibility for free.

### the three demos

All three are single-source Jack programs in `demos/`. Each one ships with its own `Main.jack`, `run-avr.sh`, and `run-hack.sh`, plus a pre-compiled `for-emulator/` folder for direct VMEmulator loading.

**Simon** (the intermediate demo).  4-step memory game. Shows N steps of a hardcoded 16-step sequence; player must repeat them. The interesting bit is how the same `flash()` function lights one LED on AVR (via byte `0x0400` mirror) AND draws a 16-pixel horizontal stripe at one of four distinct row positions on the Hack screen. Done by writing to two screen addresses per flash - one for AVR LED visibility and one for Hack display visibility. Neither write interferes with the other on the opposite platform.

More funs:

**Whack-a-Mole**. Uses the Hosyond OLED's physical yellow-and-blue split as a layout: yellow strip at the top (rows 0–15) is a horizontal score bar that grows 8 pixels per correct hit; blue area below (rows 18–31) holds four 32×14 mole slots. A random slot lights up, you press the matching button. Wrong button or score >16 → game over flash.

**Etch-a-Sketch**. Yellow strip is a HUD showing the cursor's X position as a single vertical line. Blue area is the actual canvas. Buttons 1/2/3/4 = up/down/left/right. Cursor wraps at the edges. No game over, no scoring, just drawing.

---

## highlights and reflections 

### the nArgs=0 collision in writeReturn

The standard Hack VM convention pushes five words at a call site (return address + four frame pointers). Our calling convention pushes only four - we use AVR's hardware `rcall` / `ret` for the return PC. That saves a slot but creates a problem.

For a function called with `nArgs=0`, `ARG` ends up pointing exactly at the saved-LCL slot. The standard return sequence does `*ARG = retval` to write the return value where the first argument used to be - which on our setup overwrites the saved LCL slot before we get a chance to read it.

The fix is to read saved LCL into a scratch register pair (r20:r21) **before** doing the `*ARG` write. 

### rcall / rjmp range overflow

The first end-to-end build with the full Jack OS linked exploded the AVR linker with "relocation truncated to fit" errors. AVR's `rcall` / `rjmp` use a 12-bit signed PC offset, which gives ±4 KB of reach. A full Jack OS + Pong + runtime came to 13 KB - way past `rcall`'s reach for any cross-class call.

Two fixes. First, the translator now emits `call` (4-byte absolute, full 32 KB reach) instead of `rcall` for `writeCall` and the `Sys_init` bootstrap. Second, the vector table at flash `0x0000` had the same problem reaching ISRs that ended up at the end of `.text` - the trampolines in `vectors.S` solve that. The vector table's `rjmp` now goes to a trampoline kept in the `.vectors` section right after the table (so it's reachable), and the trampoline does a full `jmp` to the real handler.

Also `rjmp main` at the end of `_reset` had to become `jmp main` for the same reason.

### the heap-base mismatch

The Hack convention is that `Memory.alloc` returns addresses starting at 2048 (heap base after stack). On AVR, address 2048 is `0x0800` - which is our keyboard byte, with everything past it being the hardware stack. There's no shared heap base that's safe on both platforms.

Resolution: `Math.jack` and `Screen.jack` were rewritten to not use `Array.new(N)` at all. Bit masks are computed inline by doubling (`mask = mask + mask`) instead of being indexed out of a pre-allocated `twoToThe` array. Costs about one extra instruction per iteration, doesn't affect demo performance.

`Memory.alloc` itself still exists but is essentially a stub on AVR - if any Jack program actually uses it, it'll return 2048 and corrupt the keyboard byte. None of the shipped demos exercise this path.

### the SSD1306 init table alignment

The 128×64 init sequence is 25 bytes long. Putting that in a `.text` `.byte` table and walking it with `lpm` works fine - except that 25 is odd, so the next label in the same section ended up at an odd byte address, and the linker rejected `rjmp` to an odd-address `_badisr`. One `.balign 2` after the table and it was happy. 

### Hack ASCII vs AVR raw button codes

The AVR Timer0 ISR writes the literal value `1`, `2`, `3`, or `4` (or `0` for none) to byte `0x0800` based on which `PIND` bit is low. The Hack keyboard register at 24576 returns the ASCII code of whatever was pressed - `'1'` is 49, `'2'` is 50, etc.

The Jack source can't tell which platform it's on, so each demo has a small normalize step at the input boundary: if the value is in `48..57`, subtract 48. Otherwise pass through. That lives in `demos/*/Main.jack` as `readButton()` / `readKey()`. Cheap, single-source, works on both.

### the OLED's yellow-and-blue split

The Hosyond 0.96″ OLED has two physical phosphor strips: yellow on rows 0–15, blue on rows 18–63, with a 1–2 row dead zone at the seam. We turned that into a feature instead of fighting it: two of the demos use the yellow strip as a HUD area and the blue strip as the main playfield. On Hack VMEmulator the same coordinates show up monochrome, but the layout still reads right (top status row + main area).

### printString and the missing String class

Output.jack originally had a standard `printString(String s)` that called `s.length()` and `s.charAt(i)`. The first end-to-end link failed with `String_length` / `String_charAt` undefined - we don't ship `String.jack`. Removed `printString` from `Output.jack`; left a comment pointing at where to drop a `String.jack` in if someone wants it later.

### MMIO byte-level mismatch with SSD1306 page layout !!! 

The translator's MMIO redirect maps `Hack address 16384+n` to `AVR byte 0x0400+(n mod 1024)` storing only the low byte of each Hack word. The SSD1306 framebuffer is page-organized (each byte = 8 vertical pixels of one column), while the Hack screen is word-organized (each word = 16 horizontal pixels of one row). They don't line up.

We accepted the mismatch. A pixel drawn at Hack `(x, y)` lights _some_ pixel on the OLED, just not at the same physical position. Demos are designed around this - the games still play correctly because the same coordinates reliably produce the same outcome on each platform, just visually rendered differently. Pixel-perfect visual equivalence would require a smarter MMIO redirect that decoded Hack pixel coordinates from the address+bit and wrote to the correct SSD1306 page byte. Out of scope for this iteration.

---

## how the files talk to each other 

```
Main.jack (game logic)
     calls↓
12/Screen.jack / Keyboard.jack / Memory.jack / etc.
     ultimately ↓
Memory.poke(addr, val) / Memory.peek(addr)
     compiles to ↓
push that 0 / pop that 0 (Jack VM bytecode)
     translated by avr_translator.py to ↓
inline range check + redirected st/ld
     into ↓
SRAM 0x0400+ (screen) or 0x0800 (keyboard)
     read/written by ↓
runtime/led_mirror.S Timer0 ISR    (LEDs + buttons)
runtime/oled_refresh.S Timer1 ISR  (OLED via runtime/ssd1306.S + i2c.S)
     drives ↓
physical LEDs / buttons / OLED display
```

A few pointers:

- **`avr_translator.py`** is the heart. It's about 30 KB of Python that you'd extend for any new VM behavior (MMIO mapping changes, additional segments, new optimization). The pre-scan at the bottom sets the `has_sys_init` flag - that's the entry point for whether the bootstrap `call Sys_init` goes into `main:`.
- **`runtime/`** is where you add or tune anything that's pure-AVR: new ISRs, more I/O drivers, different OLED layouts, etc. The vector table in `vectors.S` needs a corresponding rjmp-to-trampoline if you wire up a new vector; add a trampoline below the existing ones.
- **`12/`** is platform-neutral Jack. Don't put hardware-specific code here. If you find yourself wanting to, the right place is either the translator (for memory-mapped behavior) or the runtime (for ISR-driven behavior).
- **`build.sh`** handles the `.vm` → `.S` → `.elf` → `.hex` → flash chain. If you add new runtime files, they're picked up automatically (it `ls runtime/*.S`).
- **`build_with_os.sh`** wraps `JackCompiler.py` + concat + `build.sh`. Sys.vm goes first in the concat order so the translator's pre-scan finds the `function Sys.init` line near the top.

---

## known issues and possible furture works

- **`Output.printString` not implemented.** Calling it from Jack will fail at link time with undefined `String_length` / `String_charAt`. Drop a `String.jack` into `12/` if you need it.
- **`Output.printChar` / `printInt` / `println` are stubs**, not real text rendering. Each character draws a single pixel and advances a "cursor". You won't be able to read printed text on either target. The standard nand2tetris Output uses an 8×11 bitmap font with a 95-character table (~1 KB of data); we didn't ship it.
- **`Memory.alloc` heap base mismatch.** `nextFree` starts at 2048 (Hack convention) but on AVR that maps to the keyboard byte and beyond. Don't call `Array.new` from any Jack code that's intended to run on AVR. Math.jack and Screen.jack were both rewritten to avoid this.
- **OLED pixel layout doesn't match Hack screen layout.** A Hack rectangle on the OLED shows up as a non-obvious pattern of bytes. Demos work logically but visually look different on the two targets.
- **Sys.wait isn't a real timer.** It's a busy loop, calibrated by hand. The same `Sys.wait(N)` runs much faster on AVR than on Hack VMEmulator. Don't use it for anything time-critical.
- **No real RNG.** Whack-a-Mole uses a 16-bit linear congruential generator with a hardcoded seed, so the sequence is deterministic. Reset the chip and you get the exact same mole sequence every time.
- **No support for multiple OLEDs.** Two SSD1306s could share the I2C bus at addresses 0x3C and 0x3D, but we don't have the SRAM (2 KB total, one framebuffer is 1 KB).
- **Font and full Bresenham line not done.** `Screen.drawLine` only handles axis-aligned cases.
- **Smarter MMIO redirect.** A version that decodes Hack's screen coordinates from the address+bit position and writes to the correct SSD1306 page byte would give pixel-perfect visual equivalence between Hack and AVR.
- **String class + real font.** Drop in `String.jack` and a font for `Output.jack` and the project gets full text rendering. Significant SRAM/flash cost, but trivial to do.
- **Diagonal `drawLine` in Screen.jack.** Bresenham. Would let demos draw shapes more interesting than rectangles.
- **A more complex demo.** Once you have RNG + a real font, simple games like number-guessing or "calculator" become viable. Pong on a bigger OLED (1.3" SSD1306, drop-in compatible) would also be more playable than on the 0.96".
- **Get rid of the Memory.alloc heap-base trap.** Make the bump allocator's starting address platform-aware (the only way to do this in single-source Jack is to read it from a runtime-configured address - slightly hacky but clean).

---

## references

The most useful resources for building this:

- **ATmega328P datasheet** (Microchip). Chapters on I/O ports, Timer0/1, TWI, vectors. Search "ATmega328P datasheet".
- **AVR Instruction Set Manual** (Microchip DS40002198). Encoding details and cycle counts for every instruction. Required reading for understanding why `subi r16, 0xFF` adds 1.
- **AVR-libc reference**. Documents `<avr/io.h>`, `_SFR_IO_ADDR`, register/port macros: https://www.nongnu.org/avr-libc/user-manual/
- **avrdude**. The flash programmer. https://github.com/avrdudes/avrdude
- **SSD1306 datasheet** (Solomon Systech). I2C protocol, command set, GDDRAM layout.
- **nand2tetris** (Nisan & Schocken). The course this project builds on. VM specification is in chapters 7–8, Jack/OS is chapters 9–12. https://www.nand2tetris.org

---

## parts list (ask me for more details on how to assemble)

| Item | Qty | Notes |
|---|---|---|
| ATmega328P-PU (DIP-28) | 1 | |
| 16 MHz crystal | 1 | |
| 22 pF ceramic cap | 2 | one each side of the crystal |
| 10 kΩ resistor | 1 | RESET pull-up |
| 220 Ω resistor | 4 | LED current limit |
| LED (yellow / green / red / blue) | 4 | one per "bit" |
| Tactile pushbutton | 4 | one per direction |
| 0.96" SSD1306 OLED I2C module | 1 | the Hosyond yellow/blue variant works fine |
| USBASP programmer | 1 | |
| Breadboard + jumper wires | 1 | |


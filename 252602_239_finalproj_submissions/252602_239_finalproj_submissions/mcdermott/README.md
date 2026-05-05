# Liar's Dice - Final Project

A pirate themed Liar's Dice game for one player against the computer, written
in Jack for the Nand2Tetris VM platform. You play as Captain against a CPU
opponent named Blackbeard.

## How to compile and run

1. Open the `LiarsDice/` folder using the Jack Compiler on the Nand2Tetris website.
2. Click on "compile". Once it compiles, click "run".  The`.vm` files load in
   automatically.
3. Set the speed slider to fast and click Run.
4. Press Enter at the title screen to start the game.
5. After a game ends, press Enter again to play another round. There's no
   built in quit option, so close the emulator window when you're done.

## Rules

Both players start with 5 dice. Each round all the dice get rolled secretly.
You can see your own dice but not Blackbeard's. Players take turns making
bids of the form "there are at least N dice showing face F", counted across
all the dice on the table combined. Each new bid has to be strictly higher
than the last (higher quantity, or same quantity with a higher face).

Instead of bidding, either player can call Liar!, which reveals every die.
If the actual count is less than the bid, the bidder was lying and loses
a die. Otherwise the challenger was wrong and they lose one. First player
to lose all their dice loses the game.

## Controls

The game only reads numbers and the Enter key. Anything else gets ignored.

| Prompt              | What to type                       |
|---------------------|------------------------------------|
| Title / Game Over   | Enter, to start or restart         |
| "How many dice?"    | A number 1-10 (the bid quantity)   |
| "How many dice?"    | 0 to call Liar! on the last bid    |
| "Which face?"       | A number 1-6 (the bid face value)  |
| "Press enter..."    | Enter to continue                  |

Backspace works while you're typing a number.

## How the files fit together

`Main.jack` is the entry point. It just makes a LiarsDice object and calls
run on it.

`LiarsDice.jack` is the whole game. The title screen, the round loop, both
players' turns, all the drawing, the reveal logic, and the game over screen
all live in here.

`Random.jack` is a small random number generator for the dice rolls. I
made it a separate class because the seed lives in a static variable and
keeping it on its own class felt cleaner than dumping it into LiarsDice.

The flow is `Main.main` calls `LiarsDice.run`, which loops forever showing
title, then a game, then game over, then back to title. Inside run, each
game calls `playRound` over and over until somebody runs out of dice. Each
round calls `rollAllDice` and `animateRoll`, then alternates between
`playerTurn` and `computerTurn` until one of them calls liar (which jumps
to `callLiar`, where the reveal happens and somebody loses a die).

## Sections that were tricky

The string memory leak was the worst one. My first version of the game
crashed with an ERR6 error after a few rounds and I had no idea what was
causing it. After a lot of debugging I learned that Jack never frees
string literals you create inside methods. Every time the game printed
a prompt, a new string was getting allocated and never released, so the
heap kept filling up. The fix was to make every string a field variable
on the LiarsDice class and create them all once in the constructor. This
is why there are so many `field String` declarations near the top of
`LiarsDice.jack` (lines 30-83). It's not pretty but it was the only way
I could get the game stable across long games.

Once I knew about the string leak, i figured `Keyboard.readInt` had to
have the same issue because it builds a string internally to read what
you type. So I wrote my own version called `safeReadInt` that reads
characters one at a time using `Keyboard.keyPressed` and only uses int
variables (no heap allocations at all). It's near the top of
`LiarsDice.jack`, around line 213. The annoying part was making backspace
actually erase the digit on screen. `Output.backSpace()` only moves the
cursor, so to actually clear the character you have to backspace, print
a space over it, then backspace again.

The random number generator gave me an embarrassing bug. My first version
added a fixed step to the seed each call, but the dice always came out
in obvious patterns like 1, 2, 3, 4, 5, 1, 2, 3 over and over. It took
me way too long to realize that 4327 mod 6 = 1, so each roll was just
`previous + 1`. The fix was to vary the step using `seed / 100` so the
amount we add changes from one roll to the next.

For the dice scatter, I wanted the dice to look like they were freshly
thrown each round and not just sitting in fixed slots. To stop two dice
from ever overlapping I split the table into 5 horizontal slots and gave
each die a random offset inside its own slot. This is in `rollAllDice`.

For the block-letter title, Jack's `Output` class can only print at fixed
text-grid positions, which is way too small for a real title. So I drew
each letter manually as a few `drawRectangle` calls on a 5x7 grid. Each
letter has its own method (`drawL`, `drawI`, `drawA`, etc.) which is a
lot of methods but each one is only a few lines.

## Where I got unstuck

I wouldn't have figured out the string leak on my own in the time I had.
I posted in a Nand2Tetris-related Discord asking why my game was
crashing after a handful of rounds, and somebody pointed me at an old
thread on the official Nand2Tetris Q&A site about Jack not freeing
strings. Once I knew that was the cause, I worked out the fix myself by
going through the code and finding every place a string was being made.

The same Discord told me `readInt` had the same problem. I couldn't
find anyone's posted workaround so the `safeReadInt` code is mine. The
LCG bug I worked out by reading the Wikipedia article on linear
congruential generators and then staring at my output for an
embarrassingly long time. For Jack syntax I used the official
Nand2Tetris Jack language specification PDF, mostly when I forgot how
to declare an array or the difference between method, function, and
constructor.

The code itself is mine. I typed every line of every method and didn't
paste anyone else's code in. The help I got was diagnostic, not actual
implementation.

## Nand2Tetris concepts I used

I wanted this project to actually show what I learned this semester so
I tried to fit in as much of the course material as I could.

The whole thing is built around the OO Jack model from chapter 9. The
LiarsDice class has a constructor that sets up field variables and a
dispose method that walks every field. Random is a separate class with
a single static int (the seed), which is the static variable pattern
from the same chapter.

The memory work all came out of chapter 12. Both the string leak fix
and the custom safeReadInt come from understanding that the Jack OS
allocates on the heap and never garbage collects, so anything you make
inside a method either has to be cleaned up by you or stay around as
a field. dispose() calls Memory.deAlloc on this at the end.

For graphics, every visual on the screen is built out of drawRectangle,
drawCircle, and drawLine calls from the Screen class. The dice, the
barrel cup, the pirate skulls, the block-letter title, all of it is my
own coordinate math and there are no images loaded from disk. Drawing
letters on a 5x7 grid felt a lot like thinking about ROM-stored
character bitmaps from the hardware side of the course.

The text UI uses Output (moveCursor, printString, printInt, printChar,
backSpace, println) to lay out the three column headers, centered
prompts, and the reveal screen. For input, I used Keyboard.keyPressed
directly instead of readInt or readChar, both because I needed to
avoid the leak and because I wanted full control over which keys got
echoed to the screen.

A bunch of small things from earlier in the course also came in handy.
Jack doesn't have a modulo operator so I compute `seed mod n` as
`seed - ((seed / n) * n)`, which is the same kind of integer math we
built up out of basic gates earlier. The digit accumulation in
safeReadInt (`result = (result * 10) + digit`) is the same shift and
add pattern from the multiplier chapter.

## Known issues / limitations

The random number generator is a basic LCG. It's good enough to make
games feel different but it isn't truly random. The seed gets stirred
while the player waits at the title screen so two games in a row
aren't identical, but if you press Enter at exactly the same moment
twice in a row you'd get the same game both times.

Bid quantity is capped at 10 because the bid summary uses english
words ("Three", "Four" and so on) and I only wrote the words up to
ten.

The computer's bluff probability is hard coded at 25%. There is no
difficulty setting.

The game runs forever. There's no quit option, the player has to close
the emulator window.

The LiarsDice object is reused across games (via resetGameState) so
it only gets disposed when the program exits. That's fine in practice
because the OS cleans up at exit, but if you wanted multiple separate
sessions you'd want to dispose and recreate the object.

## Future improvements

If I had more time, multiple difficulty levels for the AI would be a
nice addition (different bluff rates and more conservative thresholds
for the easier modes). A score counter that tracks wins and losses
across multiple games would also be cool. Letting the player choose
their starting dice count (3, 5, or 10) would change the feel of the
game a lot. Sound effects through the Sys.wait based "beep" trick are
something I never got around to. And a smarter AI that remembers what
the player bid in earlier rounds would be a real improvement, since
right now Blackbeard treats every round as fresh.

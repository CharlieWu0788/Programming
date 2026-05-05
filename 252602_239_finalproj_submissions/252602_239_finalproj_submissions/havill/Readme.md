Jack Catcher
============

An interactive graphical game written in the Jack programming language
(Nand2Tetris). The player controls a basket at the bottom of the screen
using the arrow keys and catches falling objects. There are two kinds of
objects: solid blocks are safe to catch for points, and hollow blocks are
dangerous; catching one costs health. Losing all three health points ends
the game.


HOW TO RUN
----------

1. Load the project folder into the JackCompiler to generate .vm files.
2. Open the VM Emulator and load the entire folder.
3. Set the animation speed to Fast or No Animation.
4. Press Run. An instruction screen will appear; press any key to start.

Controls:
  Left arrow  - Move basket left
  Right arrow - Move basket right
  Q           - Quit

To restart, stop and re-run the program in the VM Emulator.


FEATURES
--------

- Two object types: solid blocks score a point when caught; hollow (outline)
  blocks cost a health point if caught. Missing a solid block also costs
  health; missing a hollow block is fine.

- Graphical health bar: top-right corner shows remaining health as a
  shrinking filled bar (3 segments).

- Live score displayed top-left throughout the game.

- Instruction screen shown on launch with drawn examples of each block type
  so players know what to do before the game begins.

- Pseudo-random spawning: a frame counter cycles through 16 evenly-spaced
  horizontal positions so objects appear at varied x-coordinates each round.

- Game Over screen displays the final score and holds for 4 seconds.


CLASS STRUCTURE AND RELATIONSHIPS
----------------------------------

  Main
    creates and runs CatcherGame

  CatcherGame
    owns Basket (player-controlled sprite)
    owns FallingObject (the falling block)
    drives the game loop (run)
    handles collision detection (checkCollision)
    manages score and health state
    renders the HUD (showScore, showHealth) and instruction screen (showInstructions)

  Basket
    self-contained sprite; tracks its own x/y, draws and erases itself,
    enforces screen boundaries

  FallingObject
    self-contained sprite; tracks x/y and dangerous flag, draws as solid or
    hollow rectangle, exposes isDangerous() so CatcherGame can apply the
    correct scoring rule

CatcherGame is the only class that knows about both Basket and FallingObject.
The two sprite classes are intentionally independent; neither knows the other
exists. All game logic (collision, scoring, HUD) lives in CatcherGame.


SUBTLE AND TRICKY SECTIONS
---------------------------

Collision detection (CatcherGame.checkCollision)

  The ball's x/y is its center; the basket's x/y is its top-left corner.
  The vertical trigger fires when ballY + size > basketY (ball bottom crosses
  basket top). The horizontal check uses ballX + size > basketX and
  ballX - size < basketX + width. The size constant (6) is hardcoded in both
  FallingObject and checkCollision; changing one without the other will
  silently break detection.

Frame timing (CatcherGame.run)

  Sys.wait behaves erratically in the browser-based online IDE because the JS
  engine has a minimum timer resolution of about 4ms. Values below 16ms cause
  visible stuttering. The current value of 16ms was found to be the lowest
  stable delay in the online IDE. If running on a local emulator this may
  need adjustment.

Dangerous object draw/erase (FallingObject.draw and FallingObject.erase)

  Dangerous objects are drawn as hollow rectangles using four drawLine calls.
  Erasing them requires drawing the same four lines in white, not a filled
  rectangle, since that would erase pixels inside the outline that were never
  drawn. The dangerous/safe branch must be identical in both draw and erase or
  ghost pixels will appear.

Boundary clamping (Basket.moveLeft and Basket.moveRight)

  The basket always erases at the current position, updates x, then clamps to
  the valid range before drawing. An earlier version checked the boundary
  before moving but did not account for the 8px step size, allowing the basket
  to overshoot the edge and pass out-of-bounds coordinates to drawRectangle,
  causing a VM error.


KNOWN ISSUES AND LIMITATIONS
-----------------------------

- No restart: the game must be stopped and re-run in the VM Emulator to play
  again. Jack has no way to reset OS state without re-invoking Main.main.

- Monochrome only: the Nand2Tetris screen is 1-bit (black and white). Solid
  vs. hollow shapes are used in place of color to distinguish object types.

- 16 fixed spawn positions: the pseudo-random x position cycles through 16
  slots spaced 30px apart. The pattern repeats and an experienced player can
  predict it.

- No difficulty scaling: fall speed and frame delay are constant throughout.

- Single falling object: only one object is on screen at a time.


FUTURE WORK
-----------

- Restart without reload: add a resetGame method that clears the screen and
  re-initializes all state, triggered by pressing R on the game over screen.

- True randomness: seed a PRNG from a cycle counter read at the moment the
  player first presses a key, removing the predictable spawn pattern.

- Difficulty scaling: reduce Sys.wait incrementally as the score increases to
  speed up the game over time.

- Multiple simultaneous objects: maintain an array of FallingObject instances
  and stagger their spawn times.

- Custom sprites: use the Bitmap Editor to replace the geometric shapes with
  pixel-art sprites for a more polished look.

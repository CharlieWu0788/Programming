README - Arrow Escape
Project 9 - Final Project
Karen Palacios Echeverria

WHAT IS ARROWESCAPE:
Arrow Escape is a puzzle game written in Jack. In this proof-of-concept
version, the player controls a small square using the arrow keys and
must navigate to the EXIT tile in the bottom-right corner of the screen.
Press Q at any time to quit. 

HOW TO PLAY
Arrow keys      = move the cursor around the grid
Space or Enter  = slide the arrow under the cursor
Q               = quit

Arrows that exit through the RIGHT side gap at rows 2-3 are cleared
with no penalty. Arrows that slide off any other edge are also removed
cleanly. Arrows that collide with another arrow cost one heart.

WHAT IS WORKING
- 6x6 grid draws correctly with exit gap on right side
- Six arrows placed on the board for level 1
- Cursor navigates the grid with arrow keys
- Space/Enter slides the selected arrow in its direction
- Collision detection: hitting another arrow costs a heart
- Exit detection: arrows that exit through the right gap at rows 2-3
  are cleared cleanly
- HUD displays hearts remaining and arrow count in real time
- Win condition: all arrows cleared triggers BOARD CLEARED message
- Lose condition: 0 hearts remaining triggers GAME OVER message

UPDATES
Part 1 (A9 proof of concept):
  A simple maze navigation game. The player moves a square around
  the screen with arrow keys and navigated to an EXIT tile. This
  establishes the game loop, keyboard input, screen drawing, and
  win detection patterns that carry into the final version.
  Files: Main.jack, Player.jack, ArrowEscapeGame.jack

Part 2 (Final project):
  Redesigned as a grid-based arrow sliding puzzle. The maze movement
  concept was replaced with cursor-based grid navigation and a turn-
  based slide mechanic. Board.jack and Arrow.jack were added to handle
  grid state and tile rendering separately from game logic.
  Files: Main.jack, Arrow.jack, Board.jack, ArrowGame.jack

KNOWN ISSUES AND LIMITATIONS
- Q does not seem to actually quit the game
- There are three levels to the game but you can only play level 1
- When trying to click on an arrow, wait one second before pressing space 
---> In future I would ensure that the user can quit game and that they can advance
     to the next level, I would also try and create a scoreboard in the fuure 

CLASS INFO
Main.jack
  Entry point. Creates ArrowGame and calls run().

Arrow.jack
  Draws one arrow tile on the grid. Handles draw(), erase(),
  drawCursor(), and eraseCursor() using Screen.drawRectangle calls.
  Direction is encoded as an integer: 1=right 2=left 3=up 4=down.

Board.jack
  Owns the game grid as a flat 1D Array of 36 integers simulating
  a 6x6 board. Index formula: (row * 6) + col. Handles drawGrid(),
  drawAllArrows(), slide(), drawCursor(), and eraseCursor().
  The slide() method returns 1 for clean exit, 2 for collision,
  and 0 for off-board edge.

ArrowGame.jack
  Game controller. Owns one Board. Handles keyboard input, cursor
  movement, heart tracking, HUD rendering, and win/lose detection.
  Uses a single-loop structure for stability on the web IDE.

Player.jack 
  Original player movement class from the maze version.

ArrowEscapeGame.jack (A9 legacy, kept for reference)
  Original maze game controller from part 1.

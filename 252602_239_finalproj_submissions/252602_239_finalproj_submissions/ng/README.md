Pseudo-3D Slope Game - inspired by Slope.io game

For the actual game, go to https://slopeio.org/
 
A pseudo-3D endless dodger written in Jack for the nand2tetris platform. The player rolls down a three-lane road and must dodge oncoming obstacles. The game gets faster the longer you survive.
 
---
 
## Controls
 
| Key | Action |
|-----|--------|
| ← Left arrow | Move left one lane |
| → Right arrow | Move right one lane |
 
---
 
## Feature Breakdown
 
### Pseudo-3D Road (`Platform.jack`)
The road is drawn each frame using five lines that all converge at a single vanishing point at `(256, 50)` — two outer edges, two lane dividers, and a horizon line. There is no scrolling geometry; the 3D illusion comes entirely from the obstacles and ball scaling with depth.
 
### The Ball (`Ball.jack`)
The ball sits at a fixed y-position (`y = 220`) at the bottom of the screen. Lane changes are not instant — the ball slides toward the target lane's x-coordinate by up to 3 pixels per frame, giving a smooth glide feel. Collision detection uses simple AABB (axis-aligned bounding box) overlap between the ball's circular radius and the obstacle's bounding rectangle, gated by a lane check so only same-lane obstacles are ever tested.
 
### Obstacles (`Obstacle.jack`)
Each obstacle is a rectangle stored in z-space (`z = 0..256`), where `z = 252` is the horizon and `z = 0` is at the player. Screen position and size are projected from z-space:
 
- `screenY` and `screenX` map linearly from the vanishing point to their final on-screen coordinates using `travelled = 256 - z`.
- `halfW` and `halfH` also scale linearly with `travelled`, so the obstacle grows naturally as it approaches.
**Consistent apparent speed:** A naive fixed z-step looks like the obstacle decelerates as it approaches because its on-screen size grows while its center only moves a small fixed amount. To compensate, the speed is made proportional to `travelled`:
 
```
speed = (travelled / 32) + 1
```
 
When `travelled` is small (far away), the obstacle takes small z-steps; when `travelled` is large (close up), it takes larger steps. This keeps the ratio of `delta_screenY / halfH` — the perceived speed relative to the obstacle's own size — roughly constant across the whole approach.
 
### Obstacle Spawning & Difficulty (`SlopeGame.jack`)
A pool of 5 obstacle objects is allocated once and reused throughout the game. A spawn timer counts down each frame; when it reaches zero, the next obstacle in the pool is reset and released. The spawn interval shrinks as the score climbs:
 
```
interval = 50 - (score / 10),  floored at 20 frames
```
 
This means at score 0 a new obstacle appears roughly every 1.5 seconds, and at score 300+ the gap is about 0.6 seconds. The floor of 20 keeps the game hard but not physically impossible.
 
Lane selection uses a cheap counter (`seed`) cycled mod 3 and offset by `score / 30` to avoid always repeating the same sequence.
 
### Scoring (`SlopeGame.jack`)
Score increments by 1 every 5 frames (independent of obstacles), rewarding pure survival time. At 30ms per frame this is roughly 6–7 points per second. ![SorryNotSorry](https://pbs.twimg.com/media/G3WASUdXYAAFKaz?format=jpg&name=900x900)
 
### High Score (`SlopeGame.jack`)
`highScore` is a field on the `SlopeGame` object, which is created once in `Main` and never destroyed between rounds. After each `playLoop()` exits, the current score is compared and `highScore` is updated before the game-over screen renders. This means the "NEW HIGH SCORE!" banner is always accurate. The high score is displayed in the top-right of the HUD during play and on the game-over screen.
 
### Restart (`SlopeGame.jack`)
`run()` loops indefinitely: title screen once, then `resetGame() → playLoop() → showGameOver()` repeating until the VM is stopped. `resetGame()` reinitialises all mutable state (score, timers, ball position, obstacle pool) without reallocating any objects, keeping memory usage flat across restarts. The game-over screen waits for any keypress and always returns `true`, so the loop always continues.
 
---
 
## File Overview
 
| File | Responsibility |
|------|---------------|
| `Main.jack` | Entry point — creates `SlopeGame` and calls `run()` |
| `GameManager.jack` | Thin wrapper used by the nand2tetris OS initialisation |
| `SlopeGame.jack` | Game loop, obstacle spawning, scoring, HUD, restart, high score |
| `Ball.jack` | Player movement, lane sliding, collision detection |
| `Obstacle.jack` | Z-space projection, perspective-correct speed, draw |
| `Platform.jack` | Static pseudo-3D road drawn each frame |

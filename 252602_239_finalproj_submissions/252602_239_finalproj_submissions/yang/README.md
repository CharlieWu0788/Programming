# Thunder Fighter in Jack - Barry Yang
Thunder Fighter is a fighter jet shooting game written in Jack.

The player controls a fighter with the arrow keys, shoots automatically, dodges enemy bullets, clears enemy waves, and fights boss enemies. The game ends when the player loses all HP.

# Compile and Run
Compile the project folder with a Jack compiler, then load the generated VM files in the Nand2Tetris VM Emulator. After compiling, open the compiled project folder in the VM Emulator and run.

# Controls
1. Press `S` to start.
2. Use arrow keys to move.
3. Press `Space` to pause or resume.
4. Press `R` to restart.

# Structure
`Main.jack` is the entry point. It creates one `Game` object, calls `init()`, then calls `run()`.

`Game.jack` is the controller for the whole game. It stores the score, wave number, boss count, pause state, high score, timers, random seed, player object, enemy pool, and bullet pool. Important methods include `run()` for the main loop, `update()` for one logic step, `render()` for drawing one frame, `spawnWave()` and `spawnBoss()` for enemy creation, `firePlayerBullet()` and `fireEnemyBullet()` for shooting, and `checkCollisions()` for hit detection.

`Player.jack` stores the player's x/y position, HP, hit box size, movement methods, and drawing method. `moveLeft()`, `moveRight()`, `moveUp()`, and `moveDown()` keep the player inside the screen. `takeDamage()` lowers HP, `heal()` adds HP after a boss kill, and `draw()` draws the player jet.

`Enemy.jack` stores both normal enemy and boss state. A normal enemy has 1 HP, moves down to a fixed height, then shoots. A boss uses the same class but sets the `boss` flag, has larger size, larger HP, random movement, and different shooting. Important methods include `reset()` for normal enemies, `resetBoss()` for bosses, `update()` for movement and timers, `canShoot()` for shooting decisions, `takeHit()` for damage, and `draw()`/`drawBoss()` for drawing.

`Bullet.jack` stores bullet position, size, direction, owner, speed bonus timing, and optional horizontal drift. Player bullets and enemy bullets use the same class. `reset()` and related reset methods reuse old bullet objects instead of making new ones, `update()` moves bullets and deactivates them outside the screen, and `draw()` draws a small rectangle.

`Collision.jack` has one job: it checks whether two rectangular hit boxes overlap.

# Class Relationships
`Main` only creates and starts `Game`.

`Game` owns the `Player`, the enemy pool, and the bullet pool. It is the only class that decides when to spawn waves, when to fire bullets, when to update score, and when the game is over. The other classes mostly store and update their own objects, while `Game` coordinates them.

The enemy and bullet arrays are object pools. At the start, `Game` creates a fixed number of `Enemy` and `Bullet` objects. During play, inactive objects are reset and reused, which keeps memory use stable.

`Enemy` represents both normal enemies and bosses. The `boss` flag changes HP, size, drawing, movement, and shooting behavior. This avoids needing a separate boss class.

`Bullet` is shared by both the player and enemies. The `owner` value separates player bullets from enemy bullets during collision checks: player bullets can damage enemies, and enemy bullets can damage the player.

`Collision` is stateless and is called by `Game` whenever two rectangular hit boxes need to be compared. The result tells `Game` whether to deactivate a bullet, damage an enemy, damage the player, or add score.

# Drawing and Randomness
The player, normal enemies, and bosses use direct screen memory drawing with `Memory.poke`. This is fast and gives control over bitmap shapes, but it also means their x positions should stay screen-safe and mostly aligned to 16-pixel screen words. Bullets use `Screen.drawRectangle`, because their shape is simple and they can move with small vertical and horizontal changes.

Enemy lanes use a simple pseudo-random seed, not true randomness. The seed starts at 17, mixes in the player's current x/y position plus a small constant, wraps back under 160, then maps that value into the current number of safe spawn columns. If a chosen lane is already occupied, the game tries another lane before spawning the enemy.

# Program Flow
To avoid memory problems, the game reuses enemy and bullet objects instead of creating new ones forever.

The game starts on a title screen and waits for the player to press `S`. After that, the main loop repeatedly reads keyboard input, handles pause/restart, updates the player, spawns waves when the screen is clear, updates bullets and enemies, checks collisions, redraws the screen, and waits briefly with `Sys.wait`.

The game uses small timers for player movement, bullet movement, enemy movement, player shooting, and enemy spawning, so each system can update at its own rate inside the same loop. Rendering clears the whole screen every frame, then redraws the player, active bullets, active enemies, and HUD text in that order.

During play, pressing `Space` pauses the update logic until `Space` is pressed again. Pressing `R` resets the current run while keeping the highest score.

When the player's HP reaches 0, the game shows the game-over screen with the score and highest score. Pressing `R` starts a new run.

# Waves and Bosses
Normal enemies appear in waves. Each wave contains exactly four enemy jets, and the next wave starts only after all current enemies are gone. Enemy x positions are randomized while staying inside the screen.

The wave counter increases for both normal waves and boss waves. After every four normal enemy waves, the next wave is a boss wave instead of another normal wave.

Bosses are larger enemies with their own bitmap design, HP, random movement, and three-shot bullet firing from left, center, and right. The first boss has 50 HP, and each later boss has 20 more HP than the previous boss. Boss movement also changes by boss number so later boss paths are not identical.

# Enemy Evolution
Enemy difficulty evolves only after a boss is defeated. The first normal enemy waves use the base difficulty: slower bullets, longer shooting intervals, and ten possible spawn columns.

Each defeated boss increases enemy bullet speed by 8% and decreases enemy shooting interval by 8%. Boss bullets use the same speed and interval evolution as normal enemy bullets.

Each defeated boss unlocks two more possible spawn columns for normal enemy waves, up to a maximum of 16. This makes later waves less predictable while still keeping every enemy fully visible.

# HP, Score, and Records
The player starts with 3 HP. Defeating a boss gives the player `HP++`, increasing player HP by 1.

Normal enemies give 10 points. Bosses give points equal to their HP. The game records the highest score during the session and shows a new-record message when the player beats it.

# Subtle Parts
The game uses fixed object pools for bullets and enemies. This avoids creating new objects during play and helps prevent memory errors. `MAX_BULLETS` is currently 30, so extra shots are skipped if all bullet slots are active.

Rendering mostly uses full-screen redraw. Each frame clears the screen and redraws active objects and HUD text. This is simpler than erasing individual sprites, because the game does not need to remember what was underneath a moving object.

Screen labels are stored once and reused with `Output.printString` during rendering. This keeps the code easier to read while avoiding repeated string allocation.

Player movement is intentionally quantized: each arrow-key movement changes x by 16 pixels horizontally or y by 8 pixels vertically. Together with `Sys.wait(10)`, this was the smoothest setting found through testing on my computer.

Enemy bullet speed uses integer movement plus bonus movement timing. This approximates percentage-based speed increases even though Jack does not support floating point numbers.

Even-numbered waves use angled enemy bullet patterns. Every third counted wave, including boss waves, uses a wider left-and-right bullet angle. The angle is approximated by occasionally shifting bullets left or right while they move downward.

# Known Issues and Limitations
The high score is kept only while the program is running. It is not saved to a file.

The random behavior is pseudo-random and based on simple integer seed updates, not a true random number generator.

The boss bitmap is large and drawn with many `Memory.poke` calls, which makes it harder to edit than the player drawing.

The player can move to the far right at `x = 496`, and `Player.draw()` writes one extra screen word with `memAddress + 225`. At the far right edge, that extra word can wrap into the next screen row. This is hard to notice during play; limiting movement to `x = 480` would avoid it, but would also stop the player from reaching the far right. A cleaner fix would be redrawing the player jet so its bitmap fits the screen word layout better.

The game clears the whole canvas every timestep before redrawing everything. The advantage is that moving objects never leave old pixels behind, and there is no need to restore whatever was underneath a sprite. The disadvantage is that it does more drawing work every frame, which can lower FPS on slower computers.

Keyboard input is polled once per frame, so extremely quick taps may still be missed.

On some computers, holding an arrow key makes enemies and enemy bullets slow down or appear frozen, while the player jet keeps moving quickly. This does not happen on my computer, where the game feels smooth. Possible reasons include slower emulator keyboard handling, slower full-screen redraw, and an FPS by movement-step interaction: if the machine has high enough FPS, the 16-pixel horizontal and 8-pixel vertical steps feel smooth, but lower FPS makes the same movement steps look stuck or jumpy. 

# Future Work
Improve player drawing and movement further, possibly with a more detailed pixel-based sprite and a safer far-right boundary.

Investigate the arrow-key slowdown on slower computers, possibly by reducing redraw cost, changing movement step size, or separating input responsiveness from animation speed more cleanly.

Add different enemy types with different movement patterns.

Expand the weapon upgrade system, such as stronger bullets, spread shots, shields, or temporary power-ups.

Let the player choose difficulty levels that change enemy speed, bullet speed, boss HP, or wave behavior.

Add saved high score support if persistent storage is allowed.

Add more boss attack patterns and clearer visual feedback when the boss is hit.

I hope to keep updating and improving this game in the future.

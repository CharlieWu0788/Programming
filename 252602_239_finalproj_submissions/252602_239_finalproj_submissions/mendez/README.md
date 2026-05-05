# Snake Game - Final Project Comp 239 

A Snake game written in Jack with intention to be compiled and ran in VM code thorugh the nand2tetris platform. The snake grows when it eats food, obstacles appear once the player reaches a certain score, and the player can restart once they have lost.

---

## How to Play

### Compile + Run 
- Using the JackCompiler tool from nand2tetris website, upload the folder with all .jack files in it, press compile and then run. It will comple all .jack files into .vm files and open a new screen with the vm code already uploaded. Set the execution speed to "fast" and enable keyboard before pressing run. 

### Controls
| Key | Action |
|---|---|
| Arrow up | Move up |
| Arrow down | Move down |
| Arrow left | Move left |
| Arrow right | Move right |
| R(uppercase or lowecase) | Restart after game over |

- You cannot reverse direction into yourself, for example you cannot go left if you are currently moving right.
- Once its game over press R/r to play again.

---

## Class Overview


### `Main.jack`
Allocates a `SnakeGame` and calls `run()`. Nothing else lives here.

### `SnakeGame.jack`
This is where the main game loop lives. 
- It draws and redraws the border and score display.
- Polls the keyboard in 4 × 30 ms chunks, with 120 ms total per move, and breaks early when a new arrow key is detected so that the snake responds as soon as possible.
- Checks collisions into a wall, itself, or an obstacle before calling `grow()`. 
- Runs a retry loop after each food collection to place the next food item in a cell that is not overlapping with the snake body or obstacles.
- Wraps the game loop in a restart loop on the outside so pressing R resets all states and begins a new session.

### `Snake.jack`
Tracks the snake as a pair of parallel Array objects (bodyX, bodyY) of up to 200 grid cells. Index 0 is the head. Each call to `move()` shifts every index one step back and writes the new head position into index 0. 

### `Food.jack`
In charge of maintaining a food item. The apple(although it looks like a mango) gets randomly placed on the screen but is restricted to the columns 2–29 and rows 2–13 so that it can never overlap with the border and make it impossible to reach the fruit without dying. 

### `Obstacles.jack`
Obstacles are shown as filled squares with a white X through them. They are placed on the screen after the player reaches a certain number of points. After 5 points 1 obstacle is placed. After 10 points 2 additional obstacles are placed. After 15 points 3 additional obstacles get placed every 5 points reached. The obstacles never get placed to where a food item is at or where the body of the snake is at. 


---

## Subtle/Tricky Sections

- The head of the snake includes eye pixels. After `move()` shifts the body, `bodyX[1]` is the cell that was just the head, but it still has eyes on it. In the fix, an explicit `drawBodySegment` call on `bodyX[1] removed this issue by painting over the eyes in the wrong position. 

- In an earlier version only the obstacle was checked to make sure the food didn't overlap with it. Food landing on a body segment is still wrong because when that segment is erased by tail movement as the snake moved forward, wiping the food sprite, which makes the food invisible but still collectible in the logic . This made it seem like food just dissapeared. The current retry loop checks both obstacles and every body segment to prevent this. 

- Detecting and acting on transition, not state of the key. Checking if the key changed, not if it is held down. `lastKey` stores the key observed on the previous poll. A direction change only happens when `key ≠ lastKey`. A direction change only happens the moment the key state changes, not on every frame it remains held.

- Output.moveCursor(0, 53) places text on top of the top border rectangle. Output.printString draws with a white background, which overwrites the black border pixels. The score always has to be redrawn after `drawBorder()`, not before.

---

## Known Issues and Limitations
- The body arrays are allocated once at `Array.new(200)`. Reaching 200 segments will write out of bounds with undefined behavior. 
- Maximum obstacle count is 50. Reaching this limit prevents more obstacle spawns and potential for a very long game where the player loses from lack of space rather than hitting an obstacle. 
- There is no speed increase which would defintiely increase the difficulty. 
- There is no quit option to stop mid-game. 

---

## Future Work + Enhancement 

- Add a Q option next to R on the game over screen that would have the player quit playing. This would ideally work with muliple levels so that the player could switch between levels instead of having to play the same one. 
- Track the highscore in a sessison, even after restarting the best score that the player got would be stored. It would be erased if the player reloaded the web browser. 
- Increase difficulty through different levels or modes(easy, medium, hard) which would alter speed and obstacles the player has to overcome. 
- Implement different types of food sprites insead of using the same one. 
Binary Power Saver

---

Overview

Binary Power Saver is a resource optimization game based on binary decomposition. The player is given a randomly generated appliance demand and must use an 8-bit binary configuration to supply power. Each bit corresponds to a power branch that halves the original energy output. The goal is to meet or exceed the required energy while minimizing unnecessary energy usage.

The game emphasizes efficient binary decision-making and introduces increasing complexity through an unlockable advanced battery system.

---

How to Compile and Run

1. Open the project folder in the JackCompiler.
2. Compile the entire directory (all .jack files).
3. Open the folder in the VM Emulator.
4. Run Main.vm.

Controls:

* Enter an 8-bit binary code (e.g., 10101010)
* Press Enter to submit
* After each round, press Enter again to proceed to the next round

---

Gameplay Mechanics

Each round:

* A demand (in watts) is generated
* Required Energy = Demand × 40
* The player selects an 8-bit configuration
* Each bit represents a power branch:

  * 1 = include that branch
  * 0 = exclude that branch

Example power distribution (base battery):
4000 2000 1000 500 250 125 62 31

The player must:
Supply ≥ Required Energy

---

Design Refinements and User Experience Improvements

During later stages of development, several features were intentionally added to improve clarity and usability for the player:

* The explicit formula “Required Energy = Demand × 40” was introduced so players do not need to manually compute total energy from power values. This shifts the focus away from arithmetic and toward binary optimization.

* A full power distribution table (e.g., 4000, 2000, 1000, …) is displayed each round. This helps players directly understand how each bit maps to actual energy output, reducing cognitive load and improving decision-making speed.

* The current battery capacity (e.g., 100 W, 160 W, etc.) is shown at the start of each round. This ensures that players can immediately recognize changes introduced by the advanced battery system without needing to infer them indirectly.

These refinements were not strictly required for functionality, but were added to enhance user experience, readability, and overall game clarity. They reflect a deliberate design choice to prioritize intuitive interaction over raw complexity.


Scoring System

The scoring system is based on optimal efficiency.

* The program computes the optimal binary configuration using brute-force search (0–255)
* The player is compared to this optimal solution
* Each unnecessary bit (extra power branch) reduces the score

Score formula:
Score = 100 - (extra bits × 20)

Minimum score is 0.

If the player does not reach the required energy:
→ Game ends immediately

When the score is less than 100, the game displays:

* Optimal Code
* Most Efficient Output
* Extra Bits used

---

Advanced Battery System

After reaching a total score of 300 or higher, the advanced battery system is unlocked.

In advanced mode, each round randomly selects one of the following battery levels:

* 160 W
* 240 W
* 320 W

This changes the available power distribution and increases difficulty.

---

Class Structure

Main.jack

* Entry point of the program
* Initializes and starts the game

Game.jack

* Controls game loop and progression
* Handles scoring, input validation, and advanced mode
* Contains logic for optimal solution comparison

Battery.jack

* Stores battery power and duration
* Generates energy values for each binary branch

BitCode.jack

* Handles binary string parsing
* Computes supply from player input
* Provides validation for 8-bit input
* Supports integer-based evaluation for optimal solution search

---

Tricky / Subtle Parts

1. Integer Overflow (Jack Limitation)
   Jack integers are limited to 16-bit signed values. To prevent overflow, all energy values were scaled down.

2. Optimal Solution Calculation
   The optimal configuration is determined using brute-force iteration over all 256 possible 8-bit combinations.

3. Bit Alignment Between String and Integer
   String input is read left-to-right, while integer bit operations are processed right-to-left. Careful alignment logic was required.

4. Input Validation
   The program ensures that user input is exactly 8 characters and consists only of '0' and '1'.

5. Screen Management
   The screen is cleared each round to prevent overflow of printed text and maintain readability.

---

Known Issues / Limitations

* No graphical interface (text-based only)
* No real-time interaction (round-based input)
* Limited numeric range due to Jack language constraints
* Keyboard input requires pressing Enter (no instant key detection)

---

Future Improvements

* Implement a heat pool system allowing partial operation when supply < demand
* Add visual UI using Screen API
* Introduce levels or increasing difficulty scaling
* Provide hints or partial guidance for suboptimal solutions
* Add score persistence or leaderboard

---

Conclusion

This project demonstrates binary optimization, efficient resource allocation, and system-level reasoning within the constraints of the Jack language. It combines algorithmic thinking with user interaction and showcases multiple programming techniques learned throughout the course.

This project was inspired by industrial power distribution systems and energy optimization logic done by myself in ArcNights: Endfield.
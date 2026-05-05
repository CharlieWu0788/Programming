README:

This is a drawing program! The controls are as follows:

	arrow keys -> move in the respective direction
	space -> start drawing
	delete -> start erasing
	return/enter -> stop drawing/erasing
	Z -> increase cursor size
	z -> decrease cursor size

If you would like to start playing, you can put the Final Project folder into the NAND2TETRIS Jack Compiler and run the compiled code.

~~~

Class Structure:

	The class structure is pretty basic here, I have my Main, the Game itself which handles inputs and timing, and the Cursor that handles basically everything else. (There will be comments in that class with further explanation of each functions' function)


Problem Highlights:

	The biggest problem I ran into was the cursor and how I could keep track of the drawing behind it. I ended up dedicating an array in memory to keep track of that, but it was a difficult process to debug and get working, especially since the screen "wraps around" the edge and if the cursor was on the right side of the screen, would start causing chaos on the left edge. As far as I know there aren't any major bugs, though the screen gets a little glitchy sometimes when the cursor moves as a result of the way it is drawn.
	
	The small limitation I am aware of is the very edge of the screen usually can't be drawn on due to the movement of the cursor (every 2 pixels instead of 1).


Future Plans:

	I would love to make different "colors" (shades of gray) that can be drawn with for extra creativity. Also, I would like to add different shapes of cursors. Beyond that, I would like to wrap this little project in a bow and leave it be.

~~~

Motivation/Inspiration:

	This is just a self-indulgent section, but anyone is welcome to read if they're curious about why I chose to do this project topic.

	In middle school, I started a project for an individual project program that my school did, and I just got into computer science. So, I ended up teaching myself through Khan Academy (my school was very small and we had very few electives), and I started on a project that was supposed to be one of those rainbow scratch art things with the black that you scratch away to reveal color underneath (I LOVED those as a kid). At some point in time, when I was almost done with the project, I deleted it all on accident. I cried so much, had a complete breakdown in front of my parents. Eventually I coded it all again and made it even better, and in the end, I presented it to me friend sand classmates and was so proud of it.

	Since this class was about building a computer from the ground up, I thought it was a perfect chance to go full circle and create a mirror of that very first project of mine. Since our computer has no mouse or color, I was somewhat limited in what I could make, but I think I made a faithful re-make of that original program.






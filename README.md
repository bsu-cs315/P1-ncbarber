# Project 1 Iteration 1

## How to Play
To play this game, there are some very basic controls. Use the up and down arrows (or W for up and S for down) to control the angle at which the character launches. Then you can use the left arrow (or A) to decrease the power, or the right arrow (or D) to increase. The arrow will move and indicate power and angle. Once you get it to the angle and power you think works, hit the spacebar to launch!

## Reflection
From this project, and this iteration, what I found the most interesting was the implementatoin of having an arrow to show where the character is launching. While playing around with it, it made more sense to create a node with a sprite attached that wouldn't be affected by the gravity or affect the charater sprite and change how it interacts with the rest of level. One thing that was pretty frustrating for me was the use of showing an indication that there was a collision. Funny enough one of the first times I set it up I had it right. I was looking for just a basic message in the console that would tell me that there was a collision. What I found fixed the issue is that I needed to change the Contact Reported. This made it so that everyime there was a collision with the star target, it marks it in the console. If I would have read over the project description a few more times, I probably would have figured that out a bit faster than I did. 

## Self-Evaluation

- [X] D-1: The repository link is submitted to Canvas before the project deadline.
- [X] D-2: The repository contains a <code>README.md</code> file in its top-level directory.
- [X] D-3: The project content is eligible for an <a href="https://www.esrb.org/ratings-guide/">ESRB Rating</a> of M or less.
- [X] C-1: Your repository is well-formed, with an appropriate <code>.gitignore</code> file and no unnecessary files tracked.
- [X] C-2: Your release is tagged using <a href="https://semver.org/">semantic versioning</a> where the major version is zero, the minor version is the iteration number, and the patch version is incremented as usual for each change made to the minor version, and the release name matches the release tag.
- [X] C-3: You have a clear legal right to use all incorporated assets, and the licenses for all third-party assets are tracked in the <code>README.md</code> file.
- [X] C-4: The <code>README.md</code> contains instructions for how to play the game or such instructions are incorporated into the game itself.
- [X] C-5: The project content is eligible for an <a href="https://www.esrb.org/ratings-guide/">ESRB Rating</a> of T or less.
- [X] C-6: The player can control the angle at which the projectile is fired.
- [X] C-7: The player can fire the projectile.
- [X] C-8: The projectile's flight is affected by gravity using Godot Engine's physics system.
- [X] C-9: There is a &ldquo;ground&rdquo; that stops the projectile.
- [X] C-10: There is a non-ground target that the projectile can hit.
- [X] B-1: The <code>README.md</code> file contains a personal reflection on the iteration and self-evaluation, as defined above.
- [X] B-2: The projectile's firing angle is clamped between 0&deg; (straight forward) and 90&deg; (straight up).
- [X] A-1: The player can modify the strength of the projectile's firing.
- [X] A-2: There is a visual indicator showing the angle at which the projectile will fire.
- [X] A-3: The projectile's hitting the target is recognized and logged to the console or otherwise indicated.

## Third-Party Resources

- [Kenny's Physics Assets Pack](https://kenney.nl/assets/physics-assets), licensed under 
[CC0 1.0 Universal](https://creativecommons.org/publicdomain/zero/1.0/)

- [Kenny's Physics Tanks Pack](https://kenney.nl/assets/tanks), licensed under 
[CC0 1.0 Universal](https://creativecommons.org/publicdomain/zero/1.0/)
